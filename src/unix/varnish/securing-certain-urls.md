date:    2012-10-07
category: unix
title: Securing access to certain URLs
tags: varnish, http, performance, security

This is how I've secured the vital webapps on a typical
Escenic Content Engine installation:

```
acl staff {
  "1.2.3.4";
  "1.2.3.5";
}

sub vcl_recv {
  if (!client.ip ~ staff &&
     (req.url ~ "^/escenic" ||
      req.url ~ "^/studio" ||
      req.url ~ "^/webservice" ||
      req.url ~ "^/escenic-admin")) {
    error 405 "Not allowed.";
  }
}
```

If you've got Apache in the mix, you could of course do this there as
well, but I like doing it in Varnish regardless of having Apache in
the architecture or not; the VCL syntax is so easy to read and write
and the Varnish configuration (files) are just "tighter" overall than
Apache's .conf files.
