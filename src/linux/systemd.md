title: systemd
date: 2015-07-23

## Am I running systemd or good old init?
To determine whether or not you're using old school, System V init or
systemd (or a mix!), do the following:

```
$ cat /proc/1/comm
systemd
$ ls -l /sbin/init
lrwxrwxrwx 1 root root 20 May 26 08:07 /sbin/init -> /lib/systemd/systemd
```

Here, the system is using systemd.

If System V was in use, "init" would be printed in the first command and
the latter command would show no symlink to ```systemd```.

