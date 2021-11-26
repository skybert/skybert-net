title: Check access to UDP service
date: 2021-11-25
category: linux
tags: linux

To test connectivity with ports accepting `TCP` connections, I
normally use:

```text
$ telnet <machine> <port>
```

It has the additional feature that once connected, you can interact
with the service using the protocol directly. For instance when
connecting to a web server you can perform HTTP GETs.

However, with services listening for `UDP` only, like
[NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol), `telnet`
doesn't work. You can then use
[netcat](https://nc110.sourceforge.io/):

```text
$ nc -v -u -z -w 3 ntp.example.com 123
Connection to ntp.example.com 123 port [udp/ntp] succeeded!
```

Once you get used to using `nc`, you may even start using it for
testing TCP connectivity too:

```text
$ nc -v -z -w 3 example.com 80
Connection to example.com 80 port [tcp/http] succeeded!
```

Easy when you know how :-)

