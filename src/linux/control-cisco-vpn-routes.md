title: Control Cisco AnyConnect VPN Routes
date: 2020-09-09
category: linux
tags: linux

By default Cisco AnyConnect VPN routes just about every thinkable IP
through the VPN. This is probably not what you want. Preferably, you'd
want only the company servers routed through the VPN and the rest of
your network traffic should go through the default gateway. What's
more, routing all subnets through the VPN makes lots of services fail,
for instance did my Docker and LXD containers stop working once I
connected to AnyConnect.

This snippet is written by
[Sasha Pachev](https://superuser.com/users/195546/sasha-pachev) and posted on
[https://superuser.com/a/546668/208065](https://superuser.com/a/546668/208065): 

```c
#include <sys/socket.h>
#include <linux/netlink.h>

int _ZN27CInterfaceRouteMonitorLinux20routeCallbackHandlerEv()
{
  int fd=50;          // max fd to try
  char buf[8192];
  struct sockaddr_nl sa;
  socklen_t len = sizeof(sa);

  while (fd) {
     if (!getsockname(fd, (struct sockaddr *)&sa, &len)) {
        if (sa.nl_family == AF_NETLINK) {
           ssize_t n = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
        }
     }
     fd--;
  }
  return 0;
}
```


With this patched/side loaded `vpnagentd` function, I can now use
AnyConnect and LXD containers, basically, I removed one and one
AnyConnect route until my LXD container started working, this snippet
may come in handy for others attempting the same:

```
/sbin/route -n | grep cscotun0 | awk '{print "sudo route del -net "$1 " gw "$2" netmask "$3}'; 
```

Linux users may use the same approach to tame AnyConnect, see
[https://superuser.com/a/546668/208065](https://superuser.com/a/546668/208065)
for how to create the shared library. You then need to add
`LD_PRELOAD` to the systemd unit (the article talks about the AC
`init.d` which doesn't exist anymore):

```
$ cat /lib/systemd/system/vpnagentd.service
```

```conf
[Unit] 
Description=Cisco AnyConnect Secure Mobility Client Agent 

[Service] 
Type=simple
Restart=on-failure
Environment=LD_PRELOAD=/opt/cisco/anyconnect/lib/libhack.so
ExecStartPre=/opt/cisco/anyconnect/bin/load_tun.sh
ExecStart=/opt/cisco/anyconnect/bin/vpnagentd -execv_instance
ExecReload=/bin/kill -HUP $MAINPID 
PIDFile=/var/run/vpnagentd.pid
KillMode=process

[Install] 
WantedBy=multi-user.target
```

