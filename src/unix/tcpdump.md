title: tcpdump
date:    2012-10-07
category: unix
tags: network, http, security

## Watching all the HTTP traffic

This is a great way of watching the normal HTTP traffic on a
given host using the```eth1``` interface:


    tcpdump -i eth1 -l -s0 -w - tcp dst port 80  | strings

Note that this will not print the responses from the server as
these will not have destination port```80```. To watch
both server requests and responses transmitted on my default
interface (i.e. no```-i```), I use:

    tcpdump -l -s0 -w - tcp   | strings

## Watching all communication to and from memcached

In my case, the memcached is running on its default port, 11211, and
all communication to and from it is local to the current host, hence
all the traffic goes over the loopback interface```lo```.

To view all the memcached traffic, including seeing the
key/value pairs and memcached return statuses, you can do:

    tcpdump -i  lo -s0 -w - tcp dst port 11211


