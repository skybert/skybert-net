title:  Installing Arch Linux on ASUS Zenbook UX31L
date: Mon Mar 17 19:04:45 2014
category: linux
tags: linux, arch

Except for having to read a good portion of articles related to UEFI
and GRUB, installing Arch on ASUS Zenbook UX31L was pretty easy
straight forward. Since I've never used Arch Linux before, there were
of course some new things to learn, as
[I've described in this article](../coming-to-arch-from-debian) but as
far installing Arch itself, it was pretty ok thanks to the excellent
Arch documentation.

However, there are a couple of things I'd like to highlight to aid
anyone wanting to install Arch on this beautfiul piece of hardware.

## Installation medium
I downloaded the Arch ISO and copied it to a usb drive (my USB drive
is ```/dev/sdc```):

```
$ wget http://mirror.archlinux.no/iso/2014.03.01/archlinux-2014.03.01-dual.iso
# dd \
  if=archlinux-2014.03.01-dual.iso \
  of=/dev/sdc
```

Before booting it, I went into the BIOS, err UEFI, and disabled
secure boot so that I could boot into (any) Linux kernel. After that,
I hammered one of the keys (can't remember if I hit ```Esc``` or ```F12``` to
get the boot device list menu) and selected to boot from the USB
drive.

On a related note, I tried to boot a number of distros off a USB
stick, and not all manage to boot. I believe it has something to do
with this computer requiring the medium to be booted via UEFI. So as
long as the installation medium is set up to boot via UEFI, the
installation program starts just fine.

## Touchpad
Since there's no track point (I miss the Thinkpad track point so
much!), I have to use the touchpad. I found the palm detection didn't
work particularly well, even when tweaking the synaptics settings
back and forth. Perhaps I didn't invest enough time in it, but I went
down a different route to get the touchpad to stay out of the way
when I'm typing, and basically not be bloody anoying, and that's to
set this in my [.xsession](https://github.com/skybert/my-little-friends/blob/master/x/.xsession)

### disable touch pad while typing
```
syndaemon -t -k -i 2 &
```

## Suspend to RAM

Without installing ```acpid``` or ```laptop-mode-tools```, Arch will
(when in my case you're logged in via the SLiM login manager and run a
lightweight window manager like [fluxbox](http://fluxbox.org) your
laptop when you close your lid (or indeed type ```pm-suspend```
yourself).

However, I found that often, the computer would resume immediately and
then re-mount my harddrive read only (!).

This problem went away after I installed
[laptop-mode-tools](https://wiki.archlinux.org/index.php/acpid][acpid]]
and
[[https://wiki.archlinux.org/index.php/Laptop_Mode_Tools) so I recommend you to install these right away. At the time of writing (2014-03-14), ```laptop-mode-tools``` must be installed from AUR, something I find strange for such a vital package. In any case, it builds and installs just fine.

## Recommended reading list
I found these articles particularly helpful when installing Arch on
ASUS Zenbook UX31L:

- [ASUS_Zenbook_Prime_UX31A](https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A)
- [UEFI](https://wiki.archlinux.org/index.php/UEFI)
- [UEFI_Bootloaders](https://wiki.archlinux.org/index.php/UEFI_Bootloaders)

