title: Check access to UDP service
date: 2021-11-25
category: linux
tags: linux

With ports accepting `TCP` connections, I tend to use:

```text
$ telnet <machine> <port>
```

To test connectivity. However, with services listening for `UDP` only,
like [NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol),
`telnet` doesn't work. You can then use
[netcat](https://nc110.sourceforge.io/):

```text
$ nc -v -u -z -w 3 ntp.example.com 123
Connection to ntp.example.com 123 port [udp/ntp] succeeded!
```

Easy when you know how :-)

