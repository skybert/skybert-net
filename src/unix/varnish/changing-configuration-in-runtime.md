date:    2012-10-07
category: unix
title: Loading a New Configuration While Varnish Is Running
tags: varnish, http, performance

A great feature of Varnish is that you can re-configure it
while it's running. You to this by logging on to the
administration port using```telnet:```

    # telnet localhost 6082
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    vcl.list
    200 23
    active         70 boot

    vcl.load conf1 /etc/varnish/mysite.vcl
    200 13
    VCL compiled.
    vcl.use conf1
    200 0


That's it, Varnish is now running with your modified
configuration. If you need to switch back to the initial
configuration, you do:


    vcl.list
    200 47
    available      65 boot
    active          5 conf1

    vcl.use boot


## A Gem for the Ones Who've Read This Far

One thing before I leave you, daer reader, I'd hugely recommend you to
run <a href="http://freshmeat.net/projects/rlwrap/">rlwrap</a> in
front of any telnet session. With```rlwrap```, your arrow keys work,
so does your Emacs short cuts and input history (using the up and down
arrows).

