/* See the "man vcl" for all configuration options  -*- java -*-.  */
backend default {
  .host = "127.0.0.1";

  /* 2009-11-11 we're using Tomcat directly for the time being,
   * seeing if we can live without Apache :-)
   * torstein@mysite.com */
  /*    .port = "81"; */
  .port = "8080";
}

/* **************************************** */
/* Access control lists */
/* **************************************** */
acl purge {
  "localhost";
}

acl companynetwork {
  "34.101.198.35";
}

/* **************************************** */  
/* Include cookies in the cache, profiles, forum++ use the session
 * cookie. */
/* **************************************** */  
sub vcl_hash {
  set req.hash += req.url;
  set req.hash += req.http.host;

  /* We need X-Forwarded-Host since the request is always redirected
   * from the front apache and the normal host header will thus
   * always be 'localhost'. X-Forwarded-Host will keep the original
   * host, e.g. supporter.adressa.no.
   */
  set req.hash += req.http.X-Forwarded-Host;

  /* If there's already a cookie, we include it in the hash. */
  if (req.http.Cookie) {
    set req.hash += req.http.Cookie;
  }

  hash;
}

/* Called when Varnish receives the request from the client. */
sub vcl_recv {
  /* Accept 30 second overdue objects if a request is already
   * refreshing it to avoid thread pileups. */
  set req.grace = 30s;

  if (req.http.host == "staff.escenic.com") {
    set req.backend = staff;
  }

  if (req.url ~ "/ecome/") {
    set req.backend = saikatcomputer;
  }

  if (req.request != "GET" &&
      req.request != "HEAD" &&
      req.request != "PUT" &&
      req.request != "POST" &&
      req.request != "TRACE" &&
      req.request != "OPTIONS" &&
      req.request != "DELETE") {
    /* Non-RFC2616 or CONNECT which is weird. */
    return (pipe);
  }
  if (req.request != "GET" && req.request != "HEAD") {
    /* We only deal with GET and HEAD by default */
    return (pass);
  }
  if (req.http.Authorization) {
    /* We don't cache anything that requires auhtorization, in
     * accordance with the HTTP 2616 RFC */
    return (pass);
  }

  if (req.url ~ "/escenicCaptcha$") {
    pass;
  }

  if (!client.ip ~ companynetwork &&
      (req.url ~ "^/escenic" ||
       req.url ~ "^/dashboard" ||
       req.url ~ "^/escenic-admin")) {
    error 405 "Not allowed.";
  }

  if ((req.url ~ "/dwr/" && !(req.url ~ "/dwr/.*\.js$")) ||
      req.url ~ "\.do") {
    pass;
  }

  if (req.url ~ "\.(png|gif|jpg|css)$" || req.url == "/favicon.ico") { 
    remove req.http.Cookie;
  }

  if (req.url ~ "/\?service=rss") {
    remove req.http.Cookie;
  }

  /* These pages do not use the session cookie (i.e. no use of
   * the Session object, <profile/> tags etc).
   if (req.url == "/template/v0/components/footer/esi/customFooter.jsp" ||
   req.url == "/template/v0/components/ads/esi/oasHostname.jsp" ||
   req.url == "/template/v0/components/global/esi/customTopMenu.jsp" ||
   req.url ~ "/template/v0/wireFrame/esi/includePaperCSS.jsp" ||
   req.url ~ "/template/v0/components/navigation/esi/loginbox.jsp" ||
   req.url ~ "/template/v0/wireFrame/esi/includeTnsMetrix.jsp") {
   remove req.http.Cookie;
   }
  */

  /* We don't need the session object for JavaScript that are not a
   * part of the DWR framework. */
  if ((!req.url ~ "/dwr/") && req.url ~ "\.js$") { 
    remove req.http.Cookie;
  }

  /* We normalise the host name for Non-DWR JavaScript, ECE articles
   * and the ECE multimedia archive (article images) as these are
   * guaranteed to be equal across the different supporter sites.
   */
   if (req.url ~ "/multimedia/" || 
       req.url ~ "\.ece$" ||
       (!req.url ~ "/dwr/" && req.url ~ "\.js$")) {
     set req.http.X-Forwarded-Host = "mysite.com";
   }

  if (req.request == "PURGE") {
    if (!client.ip ~ purge) {
      error 405 "Not allowed.";
    }
    lookup;
  }

  /* Java apps use cookies for the session object. */
  if (req.http.Cookie) {
    /*      remove req.http.Cookie; */
    lookup;
  }
}

/* Called when content is fetched from the backend. */
sub vcl_fetch {
  /* if the object fecthed from the backend is not cachable, e.g. if a
   * 503 is returned, then we don't want to cache it. */
  if (!obj.cacheable) {
    pass;
  }

  /* Store objects 30 seconds after they are due to be purged fore
     grace-purposes.
  */
  set obj.grace = 30s;

  /* We need the cookies, so don't remove them. If we could identify
     URLs of non-logged in users, in could make to remove the Cookie,
     though. */
  if (req.url ~ "\.(png|gif|jpg|css)$" || req.url == "/favicon.ico") { 
    set obj.ttl = 5h;
    set obj.cacheable = true;
    remove obj.http.Set-Cookie;
  } 

  if ((!req.url ~ "/dwr/") && req.url ~ "\.js$") { 
    set obj.ttl = 1h;
    remove obj.http.Set-Cookie;
  }

  /* 
   * We want ESI parsing in all JSPs, ECE articles and section pages.
   * Since section pages can have URI parameters, we've added a regexp
   * in the elseif stanza. Also, Struts actions are ESI parsed (.do).
   * 
   * Cache images (updated images get new URLs), JS (dwr is excluded in 
   * vcl_recv), SWFs and CSS forever. 
   */
  if (req.url ~ "/\?service=rss") {
    remove obj.http.Set-Cookie;
    set obj.ttl = 5m;
  }
  elseif (req.url ~ "\.jsp" || req.url ~ "\.ece" || req.url ~ "/(\?.*)?$" ||
          req.url ~ "\.do") {
    esi; 
  }
  elseif (req.url ~ "\.js$" || req.url ~ "\.css$" || req.url ~ "\.swf$") {
    set obj.ttl = 360h;
  }

  /* The ESI included JSPs (that are reside in esi directories) are
   * now setting their cache time themselves, using max-age, hence we
   * don't need a ttl directive for URIs with /esi/ in them.
   */
  if ((req.url ~ "\.jsp" || req.url ~ "\.ece" || req.url ~ "/(\?.*)?$" ||
       req.url ~ "\.do") && !(req.url ~ "/esi/")) {
    /* Right now, we're using the server for testing and don't
     * want JSPs and section pages cached. */
    /* set obj.ttl = 5m; */
    set obj.ttl = 1s;

  }
  
  /* Some ESI-elements don't set s-maxage yet. */
  if (req.url ~ "/esi/" && !obj.http.Cache-Control ~ "s-maxage") {
    set obj.ttl = 10s;
  }

  /* These pages do not use the session cookie (i.e. no use of
     the Session object, <profile/> tags etc).
     if (req.url == "/template/v0/components/footer/esi/customFooter.jsp" ||
     req.url == "/template/v0/components/ads/esi/oasHostname.jsp" ||
     req.url == "/template/v0/components/global/esi/customTopMenu.jsp" ||
     req.url ~ "/template/v0/wireFrame/esi/includePaperCSS.jsp" ||
     req.url ~ "/template/v0/components/navigation/esi/loginbox.jsp"||
     req.url ~ "/template/v0/wireFrame/esi/includeTnsMetrix.jsp") {
     set obj.ttl = 30m;
     remove obj.http.Set-Cookie;
     }
  */

  deliver;
}


sub vcl_deliver {
  /* Adds debug header to the result so that we can easily see if a
   * URL has been fetched from cache or not.
   */
  if (obj.hits > 0) {
    set resp.http.X-Cache = "HIT";
  } else {
    set resp.http.X-Cache = "MISS";
  }
}

