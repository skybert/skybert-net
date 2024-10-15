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

Explanation of the filter expression used above:

```
(((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0):
```

The filter captures only packets that contain data, i.e. packets with
a non-zero payload.

`ip[2:2]`: Refers to the total length field in the IP header. This is
a 2-byte field that indicates the entire length of the IP packet,
including headers and data.

`((ip[0]&0xf)<<2)`: Refers to the header length of the IP
packet. `ip[0]&0xf` extracts the 4-bit IP header length field (which
indicates the length in 32-bit words), and `<<2` multiplies it by `4`
to convert it into bytes.

`(tcp[12]&0xf0)>>2)`: Refers to the TCP header length. `tcp[12]&0xf0`
extracts the 4-bit TCP header length (in 32-bit words), and `>>2`
shifts right by 2 bits to convert it to bytes.

`(((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)`: This
whole expression calculates the length of the TCP payload by
subtracting the IP header length and TCP header length from the total
IP length. If this value is non-zero, it indicates that the packet
contains data beyond the headers.
