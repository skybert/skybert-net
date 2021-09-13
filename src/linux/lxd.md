title: lxd
date: 2019-11-13
category: linux
tags: linux, containers, lxd

> The more I use LXD the less I understand why we're all using
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
$ lxc start mycontainer
```

And it just works! `mycontainer` is now up and running.

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

## Run Docker containers inside an LXD container

You can even run Docker containers inside an LXD container By passing
`security.nesting=true` to `lxc` when creating a container, you can
run other containers inside it:

```text
$ lxc launch ubuntu box-in-a-box -c security.nesting=true
```

You can now `lxc exec` into the `box-in-a-box` and install Docker like
normal, after which `lxc ls` will list the Docker interfaces along
side the `eth0` device which is used for communicating with your lxd
container:

```
❯ lxc ls box-in-a-box
+--------------+---------+------------------------------+----------------------------------------------+-----------+-----------+
|      NAME    |  STATE  |             IPV4             |                     IPV6                     |   TYPE    | SNAPSHOTS |
+--------------+---------+------------------------------+----------------------------------------------+-----------+-----------+
| box-in-a-box | RUNNING | 172.18.0.1 (br-b0334a281f15) | fd42:3cb:5f02:b33b:216:3eff:fee5:2320 (eth0) | CONTAINER | 0         |
|              |         | 172.17.0.1 (docker0)         |                                              |           |           |
|              |         | 10.186.38.82 (eth0)          |                                              |           |           |
+--------------+---------+------------------------------+----------------------------------------------+-----------+-----------+
```

Note that these `172.x` IPs are not accessible from your host machine,
so you need to proxy these from something that listens on `eth0` in
the `box-in-a-box` container. I prefer running `nginx` there to proxy
requests to the Docker container IPs so that I can easily access them
from my machine.


## Grow the LXD storage
On my system, I'd just hit ENTER when installing lxd and had thus a
BTRFS backed storage pool:

```text
$ lxc storage ls
+---------+-------------+--------+--------------------------------------------+---------+
|  NAME   | DESCRIPTION | DRIVER |                   SOURCE                   | USED BY |
+---------+-------------+--------+--------------------------------------------+---------+
| default |             | btrfs  | /var/snap/lxd/common/lxd/disks/default.img | 18      |
+---------+-------------+--------+--------------------------------------------+---------+
```

To add 20 GBs to it, I did the following:

First off, to be safe than sorry, I stopped LXD:
```text
# snap stop lxd
```

After that, I grew the file itself:
```text
# sudo truncate -s +20G /var/snap/lxd/common/lxd/disks/default.img
```

Then get a hold of which loopback device it's using:
```text
# losetup | grep default.img
/dev/loop6         0      0         1  0 /var/snap/lxd/common/lxd/disks/default.img   0     512
```

Re-create it:
```text
# losetup -c /dev/loop6
```

Then finally, mount the device and use `btrfs` to resize it:
```text
# mkdir /mnt/foo
# mount /dev/loop6 /mnt/foo
# btrfs filesystem resize max /mnt/foo
# umount /mnt/foo
```

Once that was done, I started LXD again:
```text
# snap start lxd
```

My containers could now use 20GBs more.



