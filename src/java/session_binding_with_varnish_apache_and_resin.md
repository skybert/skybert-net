date:    2012-10-07
category: java
title: Session binding with Varnish, Apache and Resin
tags: varnish, apache, resin, performance

This is how I set up session binding using Varnish,
Apache/mod_proxy_balancer and three Resin application server.

## Request flow

```
varnish:80 -> apache:81 -> resin:8080
```
## Creating a load balancer cookie

Since the```mod_proxy_balancer``` insist on the cookie names being on
the form <cookie-name>.<route-label> in order to do the session
binding (see the```route``` parameter below) and Resin does not allow
you to configure this, I had to create an own routing cookie.


If you're running Tomcat, you don't need to need this as the cookies
are given the correct format for routing/session binding when you
specify the ```jvmRoute``` parameter in ```server.xml```:


    <Engine name="Catalina" defaultHost="localhost" jvmRoute="app1">


Anyways, creating a session cookie like this will add
session binding support to any application server,
including Resin:

```
public class LoadBalancerFilter implements Filter {
[..]

public static final String LB_COOKIE_NAME = "LBMEMBER";
public static final String LB_MEMBER_PREXIX = "lbmember";

public void doFilter
(ServletRequest pRequest,
ServletResponse pResponse,
FilterChain pChain)
throws IOException, ServletException {

String host = "unknown";
try {
host = InetAddress.getLocalHost().getHostName();
}
catch (UnknownHostException uhe) {
pChain.doFilter(pRequest, pResponse);
return;
}

// if we get myhost.mydomain.com, remove .mydomain.com
int periodIndex = host.indexOf(".");
if (periodIndex != -1) {
host = host.substring(0, periodIndex);
}

Cookie cookie =
new Cookie(LB_COOKIE_NAME, LB_MEMBER_PREXIX + "." + host + "; path=/");

if (pResponse instanceof HttpServletResponse) {
((HttpServletResponse) pResponse).addCookie(cookie);
}

pChain.doFilter(pRequest, pResponse);
}

[..]

}
```

Add it to your webapp descriptor (web.xml):

```
<filter>
  <filter-name>LoadBalancerFilter</filter-name>
  <filter-class>com.escenic.filter.LoadBalancerFilter</filter-class>
</filter>

[..]

<filter-mapping>
  <filter-name>LoadBalancerFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```

## Apache mod_proxy_balancer configuration

This is how to set up Apache and ```mod_proxy_balancer``` with session
binding, using the```LBMEMBER``` cookie to route the incoming requests
to the correct backend server.

```
ProxyPass / balancer://mycluster/
ProxyPassReverse / http://app1:8080/
ProxyPassReverse / http://app2:8080/
ProxyPassReverse / http://app3:8080/

# load balancing to the app servers
<Proxy balancer://mycluster>
  BalancerMember http://app1:8080 route=app1
  BalancerMember http://app2:8080 route=app2
  BalancerMember http://app3:8080 route=app3
  ProxySet stickysession=LBMEMBER lbmethod=byrequests nofailover=On
  Allow from all
</Proxy>
```


## Getting Varnish to respect sessions

Out of the box, Varnish will not treat a session like any
other request. We have to explicitly add the session cookie
to the Varnish caching hash and make sure that Varnish
doesn't throw away the cookie:


So, although Varnish 2.x has support for load balancing
multiple backend servers, it is of no good for us since we
need session binding. Hence, we just make sure that Varnish
includes the cookie in the hash and not trows it away and
then let Apache do the load balancing.

```
/* ***************************************************************** */
/* Although Varnish supports load balancing, we have to use Apache to
* do the job as Varnish does not support session binding and
* Apache/mod_proxy_balancer does. */
/* ***************************************************************** */
backend default {
  .host = "127.0.0.1";
  .port = "81";
}

/* ***************************************************************** */
/* Include cookies in the cache */
/* ***************************************************************** */
sub vcl_hash {
  set req.hash += req.url;
  set req.hash += req.http.host;
  set req.hash += req.http.cookie;
  hash;
}

[..]

sub vcl_recv {
[..]
  /* java apps use cookies for the session object. */
  if (req.http.Cookie) {
    lookup;
  }
[..]
}
```

## What about mod_cacho?

The reason why I did not use```mod_caucho``` because:


1. it didn't compile on my servers (the make file
it insisted on building the apache1 modules and building
the apache2 module directly threw many compilation errors),

2. there was no good doc on how to get it to compile and

3. I seems to me that you still have a single point of
failure. Session binding in the Resin cluster works
like that you have one Resin that knows about the
others and by that does the load balacning between
them. What if THE one goes down?


If 3) can be solved, I still have 1) and 2) against ```mod_cacucho```
:-)


