title: Running Cisco AnyConnect VPN on a Headless Machine 
date: 2021-01-04
category: linux
tags: linux, vpn

Running Cisco AnyConnect VPN on a headless Linux machine is no fun:

```text
$ /opt/cisco/anyconnect/bin/vpn connect vpn.example.com
[..]

> VPN establishment capability for a remote user is disabled.  A VPN
> connection will not be established.
```

You'll get the same problem on a local machine with a graphical
display/X if you've got another user logged in from one of the TTY
consoles. E.g. here `root` is logged in from `tty1` after first doing
`Ctrl + Alt + 1`:

```
$ w
 19:55:49 up  4:02,  5 users,  load average: 0.00, 0.04, 0.19
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
torstein tty7     :0               08:22    5:06m  1:14   1.48s /usr/bin/i3
root     tty1     -                13:28   28.00s  0.10s  0.09s -zsh
```

Even though there's no remote user on this machine, both users are
local, Cisco AnyConnect will refuse to connect to the VPN server

The reason is that the VPN client downloads a profile XML file from
the VPN server and that profile contains these lines:

```xml
<WindowsVPNEstablishment>LocalUsersOnly</WindowsVPNEstablishment>
<LinuxVPNEstablishment>LocalUsersOnly</LinuxVPNEstablishment>
```

What you want is:
```xml
<LinuxVPNEstablishment>AllowRemoteUsers</LinuxVPNEstablishment>
```

However, if you change the file, it'll get overwritten by the
AnyConnect VPN process.

Furthermore, you cannot make the file immutable:
```text
# chattr +i /opt/cisco/anyconnect/profile/AnyC-Profile.xml
```

As it'll then complain that it cannot connect to the server (happens
after you've successfully authenticated with the gateway).

The solution is threefold:

### 1/3 - Create new AnyConnect profile that works on a headless machine

First, create a version of the AnyConnect
profile XML that you get from the VPN gateway, on my system, this is
`/opt/cisco/anyconnect/profile/AnyC-Profile.xml` and create a version
of it that allows remote users to create connections:
```
$ sed 's#LocalUsersOnly#AllowRemoteUsers#g' \
  /opt/cisco/anyconnect/profile/AnyC-Profile.xml \
  > /opt/cisco/anyconnect/profile/AnyC-Profile.xml.foo
```

### 2/3 - Ensure this new AnyConnect profile is being used

Before starting your VPN connection, copy your modified of the VPN
profile. Then, listen for file system changes in this directory and
copy the file over whenever the VPN server tries to overwrite your
modified VPN profile:

```bash
# cp -v /opt/cisco/anyconnect/profile/AnyC-Profile.xml{.foo,};
  inotifywait \
    -q \
    -m \
    -e close_write \
    -r  /opt/cisco/anyconnect/profile/
  | while read f; do
    cp -v /opt/cisco/anyconnect/profile/AnyC-Profile.xml{.foo,};
  done 
```

### 3/3 - Start the VPN connection as normal

```text
$ /opt/cisco/anyconnect/bin/vpn connect vpn.example.com
```

That's it. You should now be able to start the Cisco VPN on a headless
machine, like you can with all other VPN I've worked with the last 20
years.

Happy secure surfing!

