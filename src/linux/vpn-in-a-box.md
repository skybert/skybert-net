title: VPN in a Box
date: 2024-02-06
category: linux
tags: linux, vpn

<img
  class="centered"
  style="width: 1024px"
  src="/graphics/2024/vpn-in-box.png"
  alt="vpn in box"
/>

## Why run the VPN client in a VM?

The Cisco AnyConnect VPN client will not allow you to ssh into your VM
and set up your VPN in case the server side profile is configured
with:

```xml
<LinuxVPNEstablishment>LocalUsersOnly</LinuxVPNEstablishment>
```

There [are ways to hack
this](https://skybert.net/linux/running-cisco-anyconnect-vpn-on-a-headless-machine/),
but I have come to settle on running VPN in an VM with X:

## VM with a lightweight distro and desktop environment

I run a VM with Debian. It runs X and has a light DM, like
[fluxbox](https://fluxbox.org).

## VPN

In the VM, I've installed Cisco AnyConnect VPN.

## HTTP proxy

In the VM, I've installed
[tinyproxy](http://tinyproxy.github.io/). It's started by default, so
you just need to note down the port number and use that when launching
your browsers:

```text
$ grep ^Port /etc/tinyproxy/tinyproxy.conf
Port 8000
```

## Giving the VM a name

Naming is hard, I've called it `proxy`. Since I run it in KVM managed
by `virsh`, I query it for its IP like so:

```text
$ virsh net-dhcp-leases default | grep proxy | awk '{print $5}'
192.168.122.55/24
```

And add it to my `/etc/hosts`:
```text
# tee proxy 192.168.122.55 /etc/hosts
```

Now, whenever I say `proxy`, my machine routes the request to the VM.

## Using the VPN

When I need to `ssh` into a machine that requires me to be on the VPN,
I use:

```text
$ ssh -J proxy bugs.internal
```

When I need to browse a web site that requires me to be on the VPN, I
start it with an extra option specifying the HTTP proxy:

```sh
$ google-chrome-stable --proxy-server=proxy:8000 https://machine.internal &
```

When I need to use `curl` over the VPN, I pass the `-x` parameter:
```text
$ curl -x proxy:8000 https://machine.internal
```

That's it. All other requests, I use regular browser sessions that
don't route through the VPN. Which is most of what I need: Teams,
Slack, Outlook, Git++
