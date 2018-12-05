title: RHEL 7 and CentOS 7
date: 2018-11-30
category: linux
tags: linux, redhat, centos, security, firewall, selinux

My notes on using RHEL 7 and CentOS 7

## firewalld

`iptables` isn't in `root`'s `PATH` by default, but you can access it
by its full path `/sbin/iptables`. However, RHEL/CentOS wants you to
use `firewalld` instead and the user friendly `firewall-cmd` frontend,
so you may want to start using this to earn some hipster points
😉. Interestingly enough, `firewalld` uses `iptables` behind the
scenes to manipulate `netfilter` in the Linux kernel, but can be
changed to use `nftables` instead.

### List all firewall rules
```text
# firewall-cmd --list-all
```

### Open up port 80 (http)

First make sure `public` is the right zone by running
`--get-active-zones`, then add port `80`:

```text
# firewall-cmd --get-active-zones
public
  interfaces: enp0s3
```

```text
# firewall-cmd --permanet --zone=public --add-port=80/tcp
```

## Add a network interface to an existing zone
If `firewalld` is running and your interface isn't in any of the
zones, then everything on that interface is blocked.

```text
# firewall-cmd  --permanent --zone=public --add-interface enp0s8
```

### Further reading on firewalld, iptables and netfilter
- Kernel space: [netfilter.org](https://netfilter.org/)
- [firewalld](https://firewalld.org/blog/page/2/)'s firewall backends
- [What you need to know about iptables and firewalld](https://opensource.com/article/18/9/linux-iptables-firewalld)

## SELinux

## Get SELinux status

```text
# sestatus
```

### Turn off SELinux

```text
# setenforce 0
# sed -i s#SELINUX=enforcing#SELINUX=disabled# /etc/selinux/config 
```

## Networking

### View routing table
There's no `/sbin/route`, so:
```text
$ ip route list
```

### View interfaces and IP addresses
There's no `/sbin/ifconfig`, so:
```text
$ ip addr
```

### View network interfaces
```text
$ ip link
```

### View which ports are open/listening
There's no `netstat`, but `ss` is there. `ss` has similar parameters,
so to list all processes listening on a port, I do:

```text
$ ss -nutlp
```
