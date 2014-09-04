date:    2012-10-07
category: unix
title: Squid

Squid can both be used a proxy and as a cache (reverse
proxy) server. In my job, it's always as the latter I meet
this server.

## All requests are returned with invalid HTTP header etc

The access log file looks like this:


    TCP_DENIED/400 1414 GET error:invalid-requestTCP_DENIED/400 1414
    GET error:invalid-request


Solution: the acl list configuration in
```squid.conf``` listed a wrong IP address.

