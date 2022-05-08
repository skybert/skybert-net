title: iwd
date: 2021-08-24
category: linux
tags: linux

As you may know, I really, really, [dislike Network
Manager]({filename}/network-manager.md). Luckily, there's now a
superior replacement for `wpa_supplicant`, namely `iwd`. `iwd` also
has builtin configuration and command line interface, giving me all I
want:

- Simple architecture
- Understandable, copy and paste-able text file based configuration
  that lives in standard location
- Stable, always works

## iwd configuration

Configuration for all your networks are stored in:

```text
/var/lib/iwd
```

There's one configuration file per network/access point. The suffix
indicates the kind of security used, e.g: `.psk` files are for
networks using a preshared key and `.open` files are for access points
not requiring any authentication.

## Setting static IP

First tell `iwd` to attempt assigning IP, netmask and so on:

```text
# vim /etc/iwd/main.conf
```

```conf
[General]
EnableNetworkConfiguration=true
```

ℹ️ Note, the `main.conf` cannot be a symlink, it must be a regular
file.

Then, add this to your `.psk` file:

```text
# vim /var/lib/iwd/foo.psk
```

```conf
[IPv4]
Address=192.168.1.18
Netmask=255.255.255.0
Gateway=192.168.1.1
Broadcast=192.168.1.255
DNS=192.168.1.1
```

