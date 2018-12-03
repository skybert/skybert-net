title: CentOS 7
date: 2018-11-30
category: linux
tags: linux, redhat, centos

My notes on using CentOS 7

## firewalld

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
# firewall-cmd --permanet --zone=public --add-port=80/tcp
```

## Add a network interface to an existing zone
If `firewalld` is running and your interface isn't in any of the
zones, then everything on that interface is blocked.

```text
# firewall-cmd  --permanent --zone=public --add-interface enp0s8
```

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
