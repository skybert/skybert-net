date:    2012-10-07
category: unix
title: Varnish
tags: varnish, http, performance

Varnish is my favourite cache server, here I list bits and pieces on
that I've picked up when working with this very fast and sparsely
documented cache server.

## Find the least cached URIs

To improve your cache hit ratio, the best thing to do is to
use```varnishtop``` to see the URIs that are the
most often fetched from the back end server:

    varnishtop -i TxURL

## Conditional removal of headers

A lot of J2EE applications need the Session object, which
is identified in the CGI world by the HTTP header
```jsessionid``` or
```JSESSIONID```.


However, what we often want to do, is to remove it
alltogehter (and caching the request) and only keep it for
requests that <em>really </em> need it (i.e. applications
that make use of the Session object```

```
sub vcl_fetch() {
// keep it
if (req.url ~ "^/forum/" || req.url ~ "^/shop/") {
  pass;
}
// remove the rest
  elsif (obj.http.Set-Cookie ~ "JSESSION") {
    remove obj.http.Set-Cookie;
  }
}
```

## Varnish doesn't start
```
Assert error in main(), varnishd.c line 632: Condition((daemon(1,
d_flag)) == 0) not true.  errno = 19 (No such device
```


The reason was that```/dev/null``` wasn't a
character device. To fix this, I did:

    # rm /dev/null
    # mknod -m 666 /dev/null c 1 3


## Varnish doesn't start on SLES

I had problems starting a self compiled varnish 2.0.2
running on SLES 10SP2. It configured, was built and
installed just fine, but din't start. Running
```varnishd```with -F I saw an error containing

    socket(): Address family not supported by protocol, Assert error in mgt_cli_telnet(), mgt_cli.c line 478:


Running```strace``` on ```varnishd``` give me a hunch that this has
something to do with IPv6 (believe it or not). SLES has turned off
IPv6 support per default and Varnish can therefore not understand
command line parameters defining ports and hosts for running the cache
server and admin interface on the form "localhost:80".  Installing
the```ipv6``` kernel module with ```insmod``` didn't remedy the
situation.

The solution was to use a different format when entering
hosts in the```varnishd``` parameters. On the SLES
system, I set replaced the parameters in
```/etc/sysconfig/varnish``` from

```
DAEMON_OPTS="-a :81 \
-T localhost:6082 \
-f /etc/varnish/geronimo.vcl \
-s file,/usr/local/var/lib/varnish/$INSTANCE/varnish_storage.bin,1G"
```

to:

```
DAEMON_OPTS="-a :81 \
-T 0.0.0.0:6082 \
-f /etc/varnish/geronimo.vcl \
-s file,/usr/local/var/lib/varnish/$INSTANCE/varnish_storage.bin,1G"
```

A big thanks goes to mithrandir at #varnish on <a
href="irc://irc.linpro.no">irc.linpro.no!</a>

