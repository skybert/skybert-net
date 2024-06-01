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

First, get the UUIDs of the encrypted partition, `/dev/nvme0n1p2`, and
the decrypted, mounted partition, `/dev/mapper/root`:

```
# blkid
/dev/nvme0n1p1: UUID="D0BB-3264" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="26cb7637-9a3e-4be1-b477-07af31946dee"
/dev/nvme0n1p2: UUID="0ac79fb6-12f5-4d7b-9501-f7c185f94c00" TYPE="crypto_LUKS" PARTUUID="3300b64d-1e98-443f-a59e-8c9fae104d21"
/dev/mapper/root: UUID="4941d62c-51af-4dbb-8390-51f83411edec" BLOCK_SIZE="4096" TYPE="ext4"

```

In `/etc/default/grub`, edit these two variables:
```conf
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3
cryptdevice=UUID=0ac79fb6-12f5-4d7b-9501-f7c185f94c00:root
root=/dev/mapper/root"

GRUB_ENABLE_CRYPTODISK=y
```
Note, the `cryptdevice` is UUID of the encrypted partition itself, whereas what's in `/etc/fstab` is the UUID of the decrypted and mounted partition:
```
$ grep ext4 /etc/fstab
UUID=4941d62c-51af-4dbb-8390-51f83411edec / ext4 rw,relatime 0 1
```

Every time after editing `/etc/default/grub`, re-generate the runtime conf:
```text
# grub-mkconfig -o /boot/grub/grub.cfg
```

In the generated `/boot/grub/grub.cfg`, you can see the two UUIDs of the encrypted disk, `0ac79fb6-12f5-4d7b-9501-f7c185f94c00`, and the decrypted block of the root partiation, `4941d62c-51af-4dbb-8390-51f83411edec`:

```
	linux	/vmlinuz-linux root=UUID=4941d62c-51af-4dbb-8390-51f83411edec rw  loglevel=3 cryptdevice=UUID=0ac79fb6-12f5-4d7b-9501-f7c185f94c00:root root=/dev/mapper/root
```

The final step, is to install the bootloader binary itself.  Normally,
you only need this comamnd once, this is to install the grub boot
loader binary into the right place on the disk. Whatever you put in
`--bootloader-id` will show up in the UEFI/BIOS in the computer as
well as in the machine boot menu that you typically access with
<kbd>F12</kbd>

```text
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
```

## No sounds

Got a vital clue from:
```
$ journalctl -b
```

which said (search for both `snd` and `sof`):
```
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: hda codecs found, mask 5
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: using HDA machine driver skl_hda_dsp_generic now
..
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: SOF firmware and/or topology file not found.
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: Supported default profiles
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: - ipc type 1 (Requested):
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3:  Firmware file: intel/sof-ipc4/mtl/sof-mtl.ri
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3:  Topology file: intel/sof-ace-tplg/sof-hda-generic-2ch.tplg
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: Check if you have 'sof-firmware' package installed.
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: Optionally it can be manually downloaded from:
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3:    https://github.com/thesofproject/sof-bin/
May 31 09:31:27 mithrandir kernel: sof-audio-pci-intel-mtl 0000:00:1f.3: error: sof_probe_work failed err: -2
```

I was sure I had already installed `sof-firmware`, but you know what?
I hadn't! This was shortly remedied with:

```
# pacman -S sof-firmware
# reboot
```

## Fonts in Emacs

To get the fonts for the nice icons on the mode line that
`doom-modeline-mode` puts on, I had to install the package:

```
# pacman -S ttf-nerd-fonts-symbols-mono
```

