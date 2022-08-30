title: View Active Kernel Module Parameters
date: 2022-08-30
category: linux
tags: linux

`modinfo` is nice for inspecting kernel modules and what configuration
parameters they accept. For instance, these are the power saving
optoins of the `iwlwifi` driver for my Intel Wifi card:

```text
# modinfo iwlwifi | grep power_
parm:           power_save:enable WiFi power management (default: disable) (bool)
parm:           power_level:default power save level (range from 1 - 5, default: 1) (int)
```

However, `modinfo` doesn't list the *active* value of the `power_save`
parameter. For that, you'll have to query the `/sys` file system:

```text
/sys/module/iwlwifi/parameters/power_level:0
/sys/module/iwlwifi/parameters/power_save:N
```

Now *that* correspond better to what I'd set in my `modprobe.conf.d`:
```conf
# cat /etc/modprobe.d/iwlwifi.conf .
options iwlwifi power_save=0
```
