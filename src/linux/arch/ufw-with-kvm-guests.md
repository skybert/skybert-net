title: Configure UFW to allow KVM guests
date: 2024-07-16
category: linux
tags: arch, linux, security

To allow KVM guests network access, the whole internet says you just
have to allow incoming and outcoming traffic on the `virbr0`
interface:

```text
# ufw allow in on virbr0
# ufw allow out on virbr0
```

However, it still didn't work. `journactl -f` showed:

```text
# journactl -f
..
Jul 15 11:10:16 mithrandir kernel: [UFW BLOCK]
  IN=virbr0
  OUT=wlan0
  MAC=51:50:00:50:64:ce:49:51:00:b1:cd:e9:08:07
  SRC=192.168.122.185
  DST=195.88.54.16
  LEN=60
  TOS=0x00
  PREC=0x00
  TTL=63
  ID=13981
  DF
  PROTO=TCP
  SPT=45838
  DPT=80
  WINDOW=64240
  RES=0x00
  SYN
  URGP=0
```

This was because there was no firewall rule to _forward_ traffic from
the `virbr0` interface to the `wlan0` interface to get out on the
internet:

```text
# ufw route allow in on virbr0 out on wlan0
```

With that in place, my KVM guests could access the internet as normal!
💪
