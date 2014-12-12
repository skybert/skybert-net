title: Installing Debian Linux on ASUS Zenbook UX31L
date: 2014-11-30
category: linux
tags: debian, linux

## Improve battery life
```
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs;
echo min_power > /sys/class/scsi_host/host0/link_power_management_policy
echo min_power > /sys/class/scsi_host/host1/link_power_management_policy
echo min_power > /sys/class/scsi_host/host2/link_power_management_policy
echo min_power > /sys/class/scsi_host/host3/link_power_management_policy
echo 0 > /proc/sys/kernel/nmi_watchdog;
echo auto > /sys/bus/pci/devices/0000:00:1f.6/power/control;

```

