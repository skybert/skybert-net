date:    2012-10-07
category: unix
title: Telnet
tags: network, http

## Highly Insecure...
<p class="reg">
Telnet used to be the way you'd log on to a Unix server in
the old days. Some people still use it for this (yes, I
know of big organsiations who still use it for logging in
to their Unix servers!), but this should
<strong>not</strong> be done as <cite>```telnet``` is
highly insecure</cite>.

## ...but Super Useful

However,```telnet``` is still very useful for
debugging server/network related issues and thus an
indespensible tool for Unix admins. For instances, to check
that your IRC server is able to bind to the port you
thought it would be, you can simply do:

    $ telnet my.irc.server 6667

## How to exit from a telnet session

This is something a lot people don't know, when you open a
telnet session, it actually tells you how to exit, still
many people get claustrophobic when they're inside
```telnet``` and close the entire shell window when
they're done using it. However, this is not needed, you can
simply press```Ctrl + ]``` to exit.


Now that you know this, you can recognise what telnet tells
you when you start it:

    $ telnet localhost 6667
    Trying ::1...
    Connected to localhost.
    Escape character is '^]'

:-)

