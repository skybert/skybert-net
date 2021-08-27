title: Upgrading to Debian Bullseye
date: 2021-08-23
category: linux
tags: debian, linux

## Updating my /etc/apt/sources.list

I have my [/etc/apt/sources/list in
Git](https://gitlab.com/skybert/my-little-friends/-/blob/master/debian/sources.list),
so upgrading from *Buster* to *Bullseye* was only matter of [changing
the sources list in one
place](https://gitlab.com/skybert/my-little-friends/-/commit/6fc4b35be9078372d8a62682807c470190f41fd4)
and running `git pull` on each of my machines.

Then, it was just a matter of running the same three commands I've run
for 20 year now. Debian and its `apt-get` is an excellent example of a
stable API:

```text
# apt-get update
# apt-get upgrade
# apt-get dist-upgrade
```

## Impossible to upgrade systemd

```text
Setting up systemd (247.3-6) ...
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal/180ba41197f7404e9db24ef7ccafe02c.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal/180ba41197f7404e9db24ef7ccafe02c.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal/180ba41197f7404e9db24ef7ccafe02c.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal/180ba41197f7404e9db24ef7ccafe02c/system.journal.
Detected unsafe path transition /var/log → /var/log/journal during canonicalization of /var/log/journal/180ba41197f7404e9db24ef7ccafe02c/system.journal.
dpkg: error processing package systemd (--configure):
 installed systemd package post-installation script subprocess returned error exit status 73
Errors were encountered while processing:
 systemd
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

Subsequently, pretty much all other software upgrades failed since
most things depends on something which in turn depends on `systemd`
:-(

I could reproduce this error by running:
```text
# SYSTEMD_LOG_LEVEL=debug systemd-tmpfiles --create --prefix /var/log/journal
# echo $?
73
```

After reading through [bug
#950684](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=950684), I
got a hunch the directory/ies somehow had the wrong permissions. I
checked the directories leading up to `/var/log/journal` and
discovered my `/var/log` wasn't owned by `root`:

```text
 # stat /
  File: /
  Size: 4096      	Blocks: 8          IO Block: 4096   directory
Device: 10302h/66306d	Inode: 2           Links: 19
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-06-29 15:50:23.684265901 +0200
Modify: 2021-08-21 15:11:47.230580294 +0200
Change: 2021-08-21 15:11:47.230580294 +0200
 Birth: 2020-06-29 15:46:05.000000000 +0200

# stat /var
  File: /var
  Size: 4096      	Blocks: 8          IO Block: 4096   directory
Device: 10302h/66306d	Inode: 43253761    Links: 13
Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-06-29 15:50:13.172265867 +0200
Modify: 2020-06-30 16:10:24.211542521 +0200
Change: 2020-06-30 16:10:24.211542521 +0200
 Birth: 2020-06-29 15:46:08.512265082 +0200

# stat /var/log
  File: /var/log
  Size: 4096      	Blocks: 8          IO Block: 4096   directory
Device: 10302h/66306d	Inode: 43253768    Links: 15
Access: (0755/drwxr-xr-x)  Uid: ( 1000/torstein)   Gid: (    0/    root)
Access: 2020-06-29 15:50:16.596265878 +0200
Modify: 2021-08-23 12:22:38.387804831 +0200
Change: 2021-08-23 12:22:38.387804831 +0200
 Birth: 2020-06-29 15:50:01.884265831 +0200
```

To remedy this, I changed the owner back to `root`:
```text
# chown root:root /var/log
```

With that, `apt-get dist-upgrade`ing `systemd` worked like it should
:-)
