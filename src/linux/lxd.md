title: lxd
date: 2019-11-13
category: linux
tags: linux, containers, lxd

> The more use I LXD the less I understand why we're all using
> Docker. Why oh why?

## Exposing lxd container ports on host

You can either used bridged networking or use default NAT networking
and add a route to your firewall:

```text
PORT=80
PUBLIC_IP=your_public_ip
CONTAINER_IP=your_container_ip

iptables \
  -t nat \
  -I PREROUTING \
  -i eth0 \
  -p TCP \
  -d $PUBLIC_IP \
  --dport $PORT \
  -j DNAT \
  --to-destination $CONTAINER_IP:$PORT \
  -m comment \
  --comment "forward to the container"'
```

## Export and import a container

The command line interface is so easy to use, you hardly need to look
a the documentation.


```text
$ lxc export mycontainer mycontainer.tar.gz
```

This will include all snapshots. To optimise the backup file, you
might want to look into adding `--instance-only` and
`--optimized-storage`.

This tarball can then be used on the same host or copied to a
different machine where you want the same container. To make use of
the tarball that you `export`ed, you'll of course use a command called
`import`:

```text
$ lxc import mycontainer.tar.gz
```

## Mount your home directory read/write inside an LXD container

To mount your home directory read/write inside an LXD container, do:

```text
$ lxc config device add buster myhome disk source=$HOME path=$HOME
$ lxc config set buster raw.idmap "both 1000 0"
$ lxc restart buster
```

Files written by the `root` user (which has user `id=0`) inside the
container are owned by my own `torstein` user on the host system
(which has user `id=1000`).

The crux here is the user id mapping. To give another example: If my
host user had user id `1200` and the user I wanted to map to inside
the container had id `3000`, I would instead configure:

```
$ lxc config set buster raw.idmap "both 1200 3000"
```

AFAIK, there's no Docker equivalent, see [issue 2259 in their
bugtracker](https://github.com/moby/moby/issues/2259). With docker
you need to hack around it by `chown`ing the files after mounting them
to make the user inside the container write to them (if it's not a
`root` user) and on the host system, you must `chown` files created by
the container to allow non-`root` users to write to them.

## Networking in lxd containers doesn't work

The containers don't get IPv4 addresses and networking doesn't work
from within the containers. The problem is the same on Debian, Ubuntu
and Alpine.

```text
❯ lxc list
+------------+---------+------+----------------------------------------------+------------+-----------+
|    NAME    |  STATE  | IPV4 |                     IPV6                     |    TYPE    | SNAPSHOTS |
+------------+---------+------+----------------------------------------------+------------+-----------+
| buster     | RUNNING |      | fd42:3cb:5f02:b33b:216:3eff:fe5a:710e (eth0) | PERSISTENT | 0         |
+------------+---------+------+----------------------------------------------+------------+-----------+
| first      | RUNNING |      | fd42:3cb:5f02:b33b:216:3eff:fe34:c776 (eth0) | PERSISTENT | 0         |
+------------+---------+------+----------------------------------------------+------------+-----------+
| ubuntu1904 | RUNNING |      | fd42:3cb:5f02:b33b:216:3eff:fe67:ccf1 (eth0) | PERSISTENT | 0         |
+------------+---------+------+----------------------------------------------+------------+-----------+
```

```text
❯ lxc exec buster bash
root@buster:~# ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::216:3eff:fe5a:710e  prefixlen 64  scopeid 0x20<link>
        inet6 fd42:3cb:5f02:b33b:216:3eff:fe5a:710e  prefixlen 64  scopeid 0x0<global>
        ether 00:16:3e:5a:71:0e  txqueuelen 1000  (Ethernet)
        RX packets 24  bytes 4026 (3.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 19  bytes 2934 (2.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

```text
root@buster:~# apt update
Err:1 http://deb.debian.org/debian buster InRelease
  Temporary failure resolving 'deb.debian.org'
```

The reason for this, was that my firewall blocked the requests from
the DHCP server `lxd` was running to assign IPs to the
containers. `snap` who's running `lxd` on my Debian system used the
wrong command to interact with my firewall. To solve this, I did:

```text
# update-alternatives --set iptables /usr/sbin/iptables-legacy
# update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
# snap restart lxd
```

Now, my containers got IPv4 addresses and container networking worked
like a charm:

```text
❯ lxc list
+------------+---------+----------------------+----------------------------------------------+------------+-----------+
|    NAME    |  STATE  |         IPV4         |                     IPV6                     |    TYPE    | SNAPSHOTS |
+------------+---------+----------------------+----------------------------------------------+------------+-----------+
| buster     | RUNNING | 10.186.38.200 (eth0) | fd42:3cb:5f02:b33b:216:3eff:fe5a:710e (eth0) | PERSISTENT | 0         |
+------------+---------+----------------------+----------------------------------------------+------------+-----------+
| first      | RUNNING | 10.186.38.197 (eth0) | fd42:3cb:5f02:b33b:216:3eff:fe34:c776 (eth0) | PERSISTENT | 0         |
+------------+---------+----------------------+----------------------------------------------+------------+-----------+
| ubuntu1904 | RUNNING | 10.186.38.153 (eth0) | fd42:3cb:5f02:b33b:216:3eff:fe67:ccf1 (eth0) | PERSISTENT | 0         |
+------------+---------+----------------------+----------------------------------------------+------------+-----------+
```

## Still no IPv4

On a different Debian system, I still couldn't get an IP, even after
updating `iptables` alternatives outlined in the above section.

After investigating this, I discovered that I had a DNS server running:

```text
root@geronimo ~ # netstat -nlp --tcp | grep -w 53
tcp        0      0 0.0.0.0:53              0.0.0.0:*               LISTEN      794/dnsmasq
tcp6       0      0 :::53                   :::*                    LISTEN      794/dnsmasq
```

This causes conflicts with `lxd`, which also wants to fire up its own
DNS server. Since I had to need for the DNS server (I'd forgotten why
I installed it in the first place), I removed it and restarted `lxd`:

```text
# apt-get remove dnsmasq
# snap restart lxd
```

And lo and behold, my containers were started again, this time with a
shiny IPv4 address!

## snap-confine has elevated permissions

```text
snap-confine has elevated permissions and is not confined but should
be. Refusing to continue to avoid permission escalation attacks
```

It's due to Apparmor and the kernel you're running. I remedied this
with:

```text
# apparmor_parser -r /etc/apparmor.d/*snap-confine*
# apparmor_parser -r /var/lib/snapd/apparmor/profiles/snap*
```

