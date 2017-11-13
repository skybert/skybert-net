title: OpenBSD on Thinkpad T420s
date: 2017-11-05
category: unix
tags: unix, openbsd

Getting OpenBSD 6.2 installed on my Thinkpad T420s was surprisingly
easy. This was the first time I installed OpenBSD on bare metal, so I
had a lot of wonderful discoveries this evening.

All in all, OpenBSD was a joy to use. Old school, really Unixy, no
bloat. Just edit text files and issue commands. Nothing more. No
magic. No `systemd` no PulseAudio. After installing the OS, which was
a pure text based, simple question and answer style installer (you
know, the kind of BASH scripts you made second year in Uni), it said:

<img
  src="/graphics/2017/openbsd-installer.jpg"
  alt="openbsd installer"
  class="centered"
/>

Man, I instantly fell in love in OpenBSD ♥

A quick reboot later, X came up with a login screen looking awfully
lot like `xdm`:

<img
  src="/graphics/2017/openbsd-login.jpg"
  alt="openbsd login"
  class="centered"
/>

## Network configuration
Really old school. Back to basics. So nice, so simple. Minimal conf:
See all the network devices the kernel has recognised with `ifconfig`,
then create a file:

```
/etc/hostname.<device>
```

## Wireless

After connecting my laptop to a wired connection, I installed missing
firmware for the Intel wireless card with:

```text
# fw_update -a
```

## Suspend & resume

Suspend to RAM and resume worked flawlessly without doing much. I just
had to start `apmd`:

```text
# apmd &
```

To make `apmd` start on the next boot, as well as make it scale the
CPUs up and down, I added the following to `/etc/rc/.conf.local`:
```
apmd_flags=-A
```

I could then suspend to RAM as a regular user by typing (I started `apmd`;
```
$ zzz
```

and hibernate (suspend to disk) by typing the same in upper case
letters:

```
$ ZZZ
```

## Issues

### Slow booting
I'm hit by this error: [OpenBSD 3.1 slow boot due to pciide error -
Ars Technica OpenForum](
https://arstechnica.com/civis/viewtopic.php?f=16&t=788126). Luckily
suspend and resume works flawlessly so I "never" need to do a cold
boot.


## Useful reading

Apart from the `man` pages, I found the following articles helpful:
- [OpenBSD FAQ: Networking](http://www.openbsd.org/faq/faq6.html)
- [Installing OpenBSD 6.1 on your laptop is really hard
  (not)](http://sohcahtoa.org.uk/openbsd.html#1)
- [An OpenBSD
  Workstation](http://eradman.com/posts/openbsd-workstation.html)
- [List installed packages on Linux or FreeBSD / OpenBSD system
  nixCraft](https://www.cyberciti.biz/faq/howto-display-list-of-all-installed-software/)
  
