title: Speeding up installation of Debian & Ubuntu machines
date: 2017-08-16
category: linux
tags: linux, debian, ubuntu

At work, I install and re-install Debian and Ubuntu machines all the
time. Like 20 times a day. On each run, they typically pull down 150
packages. Needless to say, it would speed things up immensely if these
packages were pull down from a local cache rather than from an
official mirror.

It turns out, this is really easy to do using the `apt-cacher-ng` 
package.

## On the machine where you want the APT cache:

```text
# apt-get install apt-cacher-ng
```

That's it. By default, it listens on all network interfaces and will
accept connections for any IP.

## On each of your Debian & Ubunu machines

My machine running `apt-cacher-ng` has the IP `192.168.56.1`. The only
thing I have to do to make all the other machines use it, is to create
this file:

```text
# cat > /etc/apt/apt.conf.d/02proxy  <<EOF
Acquire::http::proxy "http://192.168.56.1:3142";
EOF
```

All `apt-get`, `synatpic` and `apt` command should now download
packages through your APT cache proxy.

## It works!

The same `apt-cacher-ng` instance can serve both package caches for
Debian and Ubuntu and any release of the two.

You can have a look at the cached files here:

``` 
$ find /var/cache/apt-cacher-ng -name "*.deb"
```

## If you're installing machines through Virtualbox

You can serve the APT cache from your host computer and let your guest
VMs use it to speed up their installation. To get fast communication
between the host and guest machines, I've set up an additional
interface on the VirtualBox guest using the "Host only adapter" option
(`vboxnet0`).

On the guest, I then added a secondary interface to communicate on
this host-only network. On Debian based machines, this meant:

```text
# cat >> /etc/network/interfaces <<EOF
auto enp0s8
iface enp0s8 inet static
      address 192.168.56.101
EOF
```

Then a mere `ifup` command to bring it up:

```text
# ifup enp0s8
```

The interface name `enp0s8` may be different on your machine. Use
`ifconfig -a` to list all interfaces.

You can then check the connectivity with:
```
$ telnet 192.168.56.101 3142
telnet> GET /
```

If you get a response from the cache (that you're query was wrong),
you're good to go.
