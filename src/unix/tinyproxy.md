title: Create an HTTP & HTTPS proxy with tinyproxy 
date: 2023-06-19
category: unix
tags: unix, http

I run a proxy inside a KVM machine that has access to the network I
need. The KVM gateway IP is `192.168.122.1`, so inside the VM, I write
the following `~/.tinyproxy.conf`:

```ini
Port 8899
Timeout 600
Allow 127.0.0.1
Allow 192.168.122.1
```

The proxy is available in most repos, on Debian, I wrote the following
to install it:

```text
# apt-get install tinyproxy
```

Then, I start it with (the `-d` puts it in the foreground, in *debug*
mode):

```text
$ tinyproxy -c .tinyproxy.conf -d
```

That's it. From my main machine, I can now use `proxy:8899` as my
HTTPS proxy, e.g.:

```text
$ curl -x proxy:8899 https://some.network.com/ice.cream
```

