title: systemd timers (the new cron)
date: 2020-08-13
category: linux
tags: linux

You have a system everyone understands, is stable and well
documented. You believe you could make a better system, so what do you
do? Create one! Now, you have TWO systems that are to be installed,
documented and learned 🤦 Oh well, with that out of my system, let's
talk about systemd's cron replacement: timers.

## View all timers

```text
$ systemctl list-timers --all
my.timer
```

## View timer definition

```text
$ systemctl show my.timer
```
This shows the calculated values, but only viewing the actual file
that someone has written makes it all make sense (at least to me):

```text
$ cat /lib/systemd/system/my.timer
```

