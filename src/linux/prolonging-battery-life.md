date:    2012-10-07
category: linux
title: Getting the Battery to Last Longer

I've added these lines to my```/etc/rc.local``` to
make my Thinkpad X300 laptop use less power. The tips are
gathered from running the excellent```powertop``` from
Intel.


    # This wakes the disk up less frequently for background VM activity
    echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

    # Disable the unused bluetooth interface with the following command:
    hciconfig hci0 down ; rmmod hci_usb

    # Disable 'hal' from polling your cdrom with:
    hal-disable-polling --device /dev/cdrom

    # SATA ALPM link power management via:
    echo min_power > /sys/class/scsi_host/host0/link_power_management_policy

    # Disable Ethernet Wake-On-Lan with the following command:
    ethtool -s eth0 wol d


And I've added a directive about USB auto suspension to my
GRUB configuration,```/etc/default/grub```:


    GRUB_CMDLINE_LINUX_DEFAULT="quiet vga=791 usbcore.autosuspend=1"


On my```Thinkpad T420s```, I added this to my ```/etc/rc.local```:

    # Dynamic power save
    iw wlan0 set power_save on

    echo 0 > /proc/sys/kernel/nmi_watchdog

    # Enable SATA link power management for /dev/sda
    echo min_power > /sys/class/scsi_host/host0/link_power_management_policy
    echo min_power > /sys/class/scsi_host/host1/link_power_management_policy

    # VM writeback timeout
    echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

    # Sound power management
    echo Y > /sys/module/snd_hda_intel/parameters/power_save_controller
    echo 1 > /sys/module/snd_hda_intel/parameters/power_save

    # Power aware CPU scheduler
    echo 1 > /sys/devices/system/cpu/sched_mc_power_savings


