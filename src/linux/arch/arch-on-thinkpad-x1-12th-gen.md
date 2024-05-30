title: Installing Arch Linux on Thinkpad X1 Carbon 12th Gen
date: 2024-05-28
category: linux
tags: arch

## Create USB disk to boot the installer from

First, I downloaded the ISO with a torrent obtained from
https://archlinux.org/download/. I used BitTorrent client
[Deluge](https://deluge-torrent.org/).

I then used [dd](https://man7.org/linux/man-pages/man1/dd.1.html) to
write the ISO to the flash drive. I figured out the `/dev/<device>` by
running `dmesg` as I plugged in the USB disk:

```text
# dmesg
..
[40163.683166] usb 3-7: new high-speed USB device number 18 using xhci_hcd
..
[40166.445458] sd 0:0:0:0: [sda] Attached SCSI removable disk
```

The `sda` bit was all I needed, I could then run `dd` to write the
file to the disk:

```text
# dd bs=4M \
     if=tmp/archlinux-2024.05.01-x86_64.iso \
     of=/dev/sda conv=fsync \
     oflag=direct \
     status=progress
```

## Getting X1 to boot from the USB

Enter the BIOS/UEFI by hitting <kbd>F2</kbd> (or <kbd>Esc</kbd>, I
hammered on both of them) to enter the BIOS/UEFI configuration and
disable Secure Boot (which requires the OS to be signed my Microsoft's
key.

Then reboot again and hit <kbd>F12</kbd> to get the boot menu. From
there, select the USB disk.

## Let the fun begin

On my old computer next to the new one, I had the [Arch Linux
installation
guide](https://wiki.archlinux.org/title/Installation_guide) which
steps you through the different commands you must type to get the bare
boned OS installed.

### Network in the installer
I set up the wireless card with:
```text
# iwctl
station wlan0 connect my-ssid
<pasword>
exit
# dhclient -v wlan0
```

### Partioning the harddrive

```text
# cfisk /dev/nme0n1
```

### Full disk encryption

https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition

I opted for the bootloader I've used the last 15 years,
[GRUB](https://wiki.archlinux.org/title/GRUB). I did forget to
[Generatethe main GRUB configuration
file](https://wiki.archlinux.org/title/GRUB#Generate_the_main_configuration_file),
so be sure to do that.

## Boot loader

```text
# pacman -S grub efibootmgr
```

In `/etc/default/grub`:
```conf
GRUB_ENABLE_CRYPTODISK=y
```

Every time after editing `/etc/default/grub`, re-generate the runtime conf:
```text
# grub-mkconfig -o /boot/grub/grub.cfg
```

Normally, you only need this comamnd once, this is to install the grub
boot loader binary into the right place on the disk. Whatever you put
in `--bootloader-id` will show up in the UEFI/BIOS in the computer as
well as in the machine boot menu that you typically access with
<kbd>F12</kbd>

```text
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
```
