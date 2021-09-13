title: My notes on HTTP/2
date: 2021-04-14
category: network
tags: network, http, quic

## HTTP/2 performs worse than HTTP/1.1 if there's high package loss
The problem with HTTP/2 is TCP head of line blocking. If an IP packet
is lost it must be re-transmitted. This means that all the HTTP/2
frames/requests that are queued up through the TCP connection must
wait. So HTTP/2 performs much poorer than HTTP/1.1 if there's a lot of
package loss. This is because HTTP/1.1 will typically keep 5 TCP
connection opens to each domain and loosing & re-transmitting packets
in one connection doesn't impede the others

### QUIC
QUIC remedies this by using UDP

QUIC provides end to end crypto, paralell streams and no TCP head of
line blocking.  Google developed QUIC, transport layer and application
layer

### HTTP/3
IEETF tooks QUIC and create HTTP/3. It uses QUIC as the transport layer.

