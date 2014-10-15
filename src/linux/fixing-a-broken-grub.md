title: Fixing a broken GRUB
date:    2013-01-09
category: linux
tags: macosx, linux, grub

When upgrading my Mac OS X to Snow Leopard, OS X took the
liberty of wiping out both my refit boot loader and may
(chain) loader GRUB on the Linux partition. When booting Linux
after the refit screen, I got a "Unknown file system" error.


The remedy was to boot with a Linux live CD (I used <a
href="http://www.sysresccd.org">systemrescuecd</a>),
```chroot``` into the Linux partition and run
```dpkg-reconfigure``` on the GRUB package:


First, I found the name of my Linux partition by running:

    # fdisk -l /dev/sda


I found it to be```/dev/sda4``` and could proceed
with the command line magic:

    # mkdir /mnt/debian
    # mount /dev/sda4 /mnt/debian
    # mount -o bind /dev /mnt/debian/dev
    # mount -o bind /sys /mnt/debian/sys
    # mount -o bind /proc /mnt/debian/proc
    # chroot /mnt/debian
    # dpkg-reconfigure grub-pc


The crux was to run```dpkg-reconfigure``` and select
the Linux partition as the destination for GRUB. Funnily
enough, it didn't suffice to just run```update-grub```
as most people on the net speak of.

