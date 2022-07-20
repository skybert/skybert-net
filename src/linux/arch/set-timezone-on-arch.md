title: Set Timezone on Arch Linux
date: 2022-06-20
category: linux
tags: arch

## See your system's current timezone
```text
$ timedatectl status
               Local time: Mon 2022-06-20 16:05:34 CST
           Universal time: Mon 2022-06-20 08:05:34 UTC
                 RTC time: Mon 2022-06-20 08:05:34
                Time zone: Asia/Taipei (CST, +0800)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

## Change the timezone

```text
$ sudo timedatectl set-timezone Asia/Taipei
```

You can verify that `timedatectl` has done the right thing by
inspecting the `/etc/localtime` symlink:

```text
$ ls -l /etc/localtime
lrwxrwxrwx 1 root root 33 Jun 20 10:06 /etc/localtime -> ../usr/share/zoneinfo/Europe/Oslo
```

`timedatectl` doesn't update `/etc/timezone` for some reason, so I
edit that manually with:

```text
# vim /etc/timezone
```

## View all available timezones

If you don't know what the timezone string is called, you should have
TAB completion, if this hasn't been enabled on your system, you can
have a look at all the available ones with:

```text
$ timedatectl list-timezones
```


