date:    2012-10-07
category: unix
title: Maximum Number of TCP connections
tags: performance, freebsd, linux, network

I've been quite confused about the total number of open TCP
connections a host can have. Most articles on the web seem to only
partly answer this question. Most emphasise the need of increasing the
number of file handles a user process can have open (```ulimit -u```)
or the total number of files the kernel can have open (viewable
in```/proc/sys/fs/file-max```).


However, the real problem is the limit of ports that can be
open. This is
because <a href="http://www.faqs.org/rfcs/rfc793.html"> the TCP
specification</a> states that the number of ports the host can
handles is defined by a 16bit number. This gives a theoretical
maximum of 65535 open connections. When setting up a connection,
the host uses a (anonymous) local port and binds it to the
requesting host:
```localhost:1212 ->
otherhost:2332```


Luckily, the story doesn't stop there. Albeit the number of
ports are limited to this number, a local port can be used to
connect to multiple IPs. Hence, the number of theoretical
connections is
```(65535 - open normal files) * number of
connecting IPs```


This implies that scaling any host that reaches the celing of
65535 incoming connections, is to add a(nother) reverse proxy in
front of it so that there are more incoming IPs that can
generate more TCP connections (which must all have a unique
combination of origin server, origin port, destination server
and destination port.


cacheserver:80 -> proxy1:1024
cacheserver:80 -> proxy1:1025
[..]
proxy1:655535



Another way to solve this,
is to create multiple interfaces on the host and make the
service listen to these (this might feel more  like a hack than
a proper solution).


In practice, this problem will only occur to the
server layer receiving traffic from the outside world; your
cache or web server. In multi server architectures, the servers
behind the front layer, e.g. the database in a
```internet
-> web server -> database``` setup, will never have a
need of scaling the number of TCP connection.


It is also worth noticing, that the load balancer in front of
your first/top layer must be fully transparent, so that it
doesn't expose its IP to the web or cache servers serving the
requests. With hardware load balancers, this is less of a
problem, but with software balancers, such
as <a href="http://haproxy.1wt.eu/"> HA
Proxy</a>, heed must be taken <a href="http://blog.loadbalancer.org/configure-haproxy-with-tproxy-kernel-for-full-transparent-proxy/">
as outlined in this article</a>.


Good articles on the subject:


-
<a href="http://rerepi.wordpress.com/2008/04/19/tuning-freebsd-sysoev-rit/">
Tuning FreeBSD for many incoming connections.
</a>


