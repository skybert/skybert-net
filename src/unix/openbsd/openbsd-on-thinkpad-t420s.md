title: openbsd-on-thinkpad-t420s
date: 2017-11-05
category: unix
tags: unix, openbsd

Getting OpenBSD 6.2 installed on my Thinkpad T420s was surprisingly
easy. This was the first time I installed OpenBSD on bare metal, so I
had a lot of wonderful discoveries this evening.

All in all, OpenBSD was a joy to use. Old school, really Unixy, no
bloat. Just edit text files and issue commands. Nothing more. No
magic. No `systemd` no PulseAudio. After installing the OS, which was
a pure text based installer, asking you questions and you typing a
word or hitting Enter in response, it said:


Man, I instantly fell in love in OpenBSD.

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

## Suspend

Suspend to RAM and resume worked flawlessly without doing much. I just
had to start `apmd`:

And could then suspend to RAM as a regular user by typing;
```
$ zzz
```

and hibernate (suspend to disk) by typing the same in upper case letters:

```
$ ZZZ
```


