title: tcpdump
date:    2012-10-07
category: unix
tags: network, http, security

## Watching all the HTTP traffic

This is a great way of watching the normal HTTP traffic on a
given host using the```eth1``` interface:

```text
# tcpdump -i eth1 -l -s0 -w - tcp dst port 80  | strings
```

Note that this will not print the responses from the server as
these will not have destination port```80```. To watch
both server requests and responses transmitted on my default
interface (i.e. no```-i```), I use:

```text
# tcpdump -l -s0 -w - tcp   | strings
```

## Watching all communication to and from memcached

In my case, the memcached is running on its default port, 11211, and
all communication to and from it is local to the current host, hence
all the traffic goes over the loopback interface```lo```.

To view all the memcached traffic, including seeing the
key/value pairs and memcached return statuses, you can do:

```text
# tcpdump -i  lo -s0 -w - tcp dst port 11211
```

## Exclude packets without a payload

```text
# tcpdump \
  -i any \
  -nn \
  -A \
  -s 0 \
  'tcp port 8680 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)'
```

This excludes captures HTTP requests to port `8680`, but excludes the
packets where there's only header sent and no payload.

