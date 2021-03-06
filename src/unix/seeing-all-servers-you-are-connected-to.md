title: Seeing All Servers You Are Connected To
date:    2012-10-07
category: unix
tags: network

With Linux and Unix systems, it's easy to figure out what
external systems your computer or server is connected to. For
instance, to see which external servers my local desktop
applications are connected to, I ran this (I've removed some of
the output for illustration purposes):

    # netstat -W -p --tcp
    [..]
    tcp        0      0 192.168.1.105:35047     baymsg1020113.gateway.edge.messenger.live.com:msnp ESTABLISHED 13208/pidgin
    tcp        0      0 192.168.1.105:55846     api-read-11-02-snc4.facebook.com:https ESTABLISHED 2774/chrome
    [..]


As you can see, it first lists the local port from which the
socket to the external server is opened. Really nifty to
illustrate the number of ports that are in play on your local
computer in order to make the various connections/sockets open
to the outside world.

## Seeing All Running Services on Your Host

Another```netstat``` command I'm often using is one that
tells me what services are on a given host. The below command
give me all the ports, PIDs and programs that are listening for
incoming TCP connections on the current host:

    # netstat -W -nlp  --tcp
[..]
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      1770/nginx
tcp        0      0 127.0.0.1:6082          0.0.0.0:*               LISTEN      1473/varnishd
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      3257/sshd
tcp        0      0 0.0.0.0:389             0.0.0.0:*               LISTEN      1994/slapd
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN      1963/mysqld
[..]

## There's Even More

```netstat``` has so many more options, but this should
at least weten your apatite :-) See its <a
href="http://linux.die.net/man/8/netstat">well written man
page</a> for more options and explanations. Also note that the
options to the command vary from system. E.g. Linux typically
has more "comfort" options than Solaris and Mac OS.

