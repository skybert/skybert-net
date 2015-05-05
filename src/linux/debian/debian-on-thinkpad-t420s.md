date:    2013-05-05
category: linux
tags: debian, linux
title: Installing Debian on Thinkpad T420s

## GRUB

I've passed the following Linux parameters via GRUB's
```/etc/default/grub```:


    GRUB_CMDLINE_LINUX_DEFAULT="quiet pcie_aspm=force i915.semaphores=1 i915.i915_enable_rc6=1 i915.i915_enable_fbc=1 i915.lvds_downclock=1"


```i915.semaphores=1```: "Enablement of semaphores solves several
stability issues on Ivy Bridge graphics cards, such as GPU hangs, and
improved stability and performance on Sandy Bridge generation of
graphics cards". See <a
href="http://intellinuxgraphics.org/2011Q4.html">Intel 2011Q4 graphics
package</a> for more details.

## Wireless

I've experienced instable wireless, often it would just seize to
function. The <a
href="http://bugzilla.intellinuxwireless.org/show_bug.cgi?id=2315">bug
is described here on Intel Linux Wireless</a>


To remedy the problem, I did the following:


    # echo "options iwlwifi 11n_disable=1" &gt; /etc/modprobe.d/iwlwifi.conf
    # update-initramfs -u


Since I don't like rebooting when I really don't have to, I
did the following to activate the changes:


    # modprobe -r iwlwifi
    # modprobe iwlwifi


Detailed information about the wireless card:


    03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205 (rev 34)
    Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN
    Flags: bus master, fast devsel, latency 0, IRQ 48
    Memory at f2900000 (64-bit, non-prefetchable) [size=8K]
    Kernel driver in use: iwlwifi


## Battery life

I've added the following to```/etc/rc.local``` to enhance the battery
life. With these in place, ```powertop``` lists all the "Toggleables"
as "Good":


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


