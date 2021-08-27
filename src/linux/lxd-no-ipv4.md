title: No IPv4 for LXD containers
date: 2021-04-30
category: linux
tags: linux, containers, lxd


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

### Still no IPv4

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

### If the lxd containers still doesn't get an IP

Could be your kernel isn't new enough. LXD will default to
`iptables-legacy` if you're running a kernel older than `5.x`. lxd
will then add rules to `iptables-legacy`, even though the rest of your
system is using `iptables-nft` and you have set
`/etc/alternatives/iptables` to point to `iptables-nft`.

You can see this if you do:
```text
# iptables-nft -L
..all your regular rules...
```

But LXD has still used the old `iptables`:
```text
# iptables-legacy -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain /* generated for LXD network lxdbr0 */
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain /* generated for LXD network lxdbr0 */
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps /* generated for LXD network lxdbr0 */

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere             /* generated for LXD network lxdbr0 */
ACCEPT     all  --  anywhere             anywhere             /* generated for LXD network lxdbr0 */

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp spt:domain /* generated for LXD network lxdbr0 */
ACCEPT     udp  --  anywhere             anywhere             udp spt:domain /* generated for LXD network lxdbr0 */
ACCEPT     udp  --  anywhere             anywhere             udp spt:bootps /* generated for LXD network lxdbr0 */
```

To remedy this, clear all the rules of both tables:
```bash
for ipt in iptables iptables-legacy ip6tables ip6tables-legacy; do
  $ipt --flush; $ipt --flush -t nat;
  $ipt --flush -t mangle;
  $ipt --delete-chain;
  $ipt --delete-chain -t nat;
  $ipt -P FORWARD ACCEPT;
  $ipt -P INPUT ACCEPT;
  $ipt -P OUTPUT ACCEPT;
done
```
And then reload LXD:
```text
# systemctl reload snap.lxd.daemon
```

Your containers should now have IPs again 😃

