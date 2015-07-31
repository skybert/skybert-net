title: KVM
date:    2013-01-23
category: linux
tags: kvm, virtualisation, debian

## Creating a new image

    $ qemu-img create -f qcow2 image.img 20G

## Bridged networking

This is what I did to set up bridged networking for my KVM guests:

```
# vim /etc/network/interfaces
```

And set my wired interface to `manual` and define a bridge interface
`br0` which my KVM guests will use.

```
iface eth0 inet manual
      post-up ifup br0

iface br0 inet dhcp
      bridge_ports eth0
```

## Starting the KVM guest

Starting the KVM guest by booting from its CDROM using the Debian
stable ISO as the CD:

```
# kvm -net nic,macaddr=00:00:00:00:00:04 \
      -net tap \
      -cdrom /home/torstein/tmp/debian-8.1.0-amd64-netinst.iso \
      -boot d
      -m 1024 \
      /home/torstein/virtual/wind.img
```
