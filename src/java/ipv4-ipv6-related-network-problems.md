date:    2012-10-07
category: java
title: IPv4/6 Related Network Problems

Last week (2010-01-19 or so), I stumbled into an IPv4/6
problem with Java. It turns out, this is due to a known
issue from 2005:
<a href="http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6342561">
http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6342561
</a>


If any of you Unix/Linux users are getting IPv4/6 related
network problems (you'll notice this because Java programs,
e.g. Maven, all of a sudden get "Connection failed" messages
when downloading artifactcs), make sure
```/etc/sysctl.d/bindv6only.conf``` has:

    net.ipv6.bindv6only = 0


and reboot, or to just try it out (non persistent):

    # echo 0 > /proc/sys/net/ipv6/bindv6only

or add:
    java.net.preferIPv4Stack=true

to your JVM options.

Debian users pulling from the testing or unstable pool have
experienced this problem for a week now, if derivatives such
as Ubuntu haven't yet, you're probably up for it in the next
release(s) ;-)


