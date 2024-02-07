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

```bash
$ virsh net-dhcp-leases default | grep proxy | awk '{print $5}'
192.168.122.55/24
```

And add it to my `/etc/hosts`:
```text
# tee proxy 192.168.122.55 /etc/hosts
```

Now, whenever I say `proxy`, my machine routes the request to the VM.

## Using the VPN


### SSH through the VPN
When I need to `ssh` into a machine that requires me to be on the VPN,
I use:

```text
$ ssh -J proxy bugs.internal
```


### Web browser through the VPN
When I need to browse a web site that requires me to be on the VPN, I
start it with an extra option specifying the HTTP proxy:

```sh
$ google-chrome-stable --proxy-server=proxy:8000 https://accounting.internal &
```

When I need to use `curl` over the VPN, I pass the `-x` parameter:
```text
$ curl -x proxy:8000 https://accounting.internal
```

## Maven through the VPN

In my `.zshrc` (`.bashrc` work just the same), I have the following
that adds proxy settings to the `MAVEN_OPTS` variable depending on an
internal website is available:

```bash
curl --max-time 1 --fail -s -x proxy:8899 -I https://bugs.internal/ && {
  export MAVEN_OPTS="${MAVEN_OPTS}
    -Dhttp.proxyHost=proxy
    -Dhttp.proxyPort=8000
    -Dhttps.proxyHost=proxy
    -Dhttps.proxyPort=8000
  "
}
```

### <anything> through the VPN

Most command line programs support the environment variables:
```bash
no_proxy=localhost
http_proxy=
https_proxy=
```

I have the following in my `.zshrc` to set these variables dynamically:
```bash
curl --max-time 1 --fail -s -x proxy:8899 -I https://bugs.internal/ && {
  export no_proxy=localhost
  export NO_PROXY=${no_proxy}
  export http_proxy='http://proxy:8000
  export https_proxy=${http_proxy}
  export HTTP_PROXY=${http_proxy}
  export HTTPS_PROXY=${http_proxy}
}
```

## Success

That's it. All other requests, I use regular browser sessions that
don't route through the VPN. Which is most of what I need: Teams,
Slack, Outlook, Git++

Happy networking!
