title: Fully encrypted hard disk, including /boot
date: 2021-08-27
category: linux
tags: linux, security

```text
root@quanah ~ #  lsblk -o NAME,FSTYPE,MOUNTPOINT /
lsblk: /: not a block device
root@quanah ~ #  lsblk -o NAME,FSTYPE,MOUNTPOINT 
NAME                    FSTYPE      MOUNTPOINT
nvme0n1                             
├─nvme0n1p1             vfat        
├─nvme0n1p2             ext2        
└─nvme0n1p3             crypto_LUKS 
  └─nvme0n1p3_crypt     LVM2_member 
    ├─quanah--vg-root   ext4        /
    └─quanah--vg-swap_1 swap        [SWAP]
root@quanah ~ # cryptsetup luksFormat --type luks1 /dev/nvme0n1p2 
WARNING: Device /dev/nvme0n1p2 already contains a 'ext2' superblock signature.

WARNING!
========
This will overwrite data on /dev/nvme0n1p2 irrevocably.

Are you sure? (Type uppercase yes): YES
Enter passphrase for /dev/nvme0n1p2: 
Verify passphrase: 
root@quanah ~ # uuid="$(blkid -o value -s UUID /dev/nvme0n1p2)"
root@quanah ~ # echo "boot_crypt UUID=$uuid none luks" | tee -a /etc/crypttab
boot_crypt UUID=feb776d4-47ed-4dc0-83a3-cd0788cec7f6 none luks
root@quanah ~ # cat /etc/crypttab 
nvme0n1p3_crypt UUID=ad321585-fba2-478f-a58f-5e7c8f9f8b24 none luks,discard
boot_crypt UUID=feb776d4-47ed-4dc0-83a3-cd0788cec7f6 none luks
root@quanah ~ # 
```



```text
root@quanah ~ #  cryptdisks_start boot_crypt
Starting crypto disk...boot_crypt (starting)...Please unlock disk boot_crypt:  ********
boot_crypt (started)...done.
root@quanah ~ # 
```


```text
root@quanah ~ # grep /boot /etc/fstab
# /boot was on /dev/nvme0n1p2 during installation
UUID=cce88557-9c08-4039-94f6-0940522cd0ce /boot           ext2    defaults        0       2
# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=D151-C2DF  /boot/efi       vfat    umask=0077      0       1
```

## Create file system on the encrypted /boot partition
```text
root@quanah ~ # mkfs.ext2 -m0 -U cce88557-9c08-4039-94f6-0940522cd0ce /dev/mapper/boot_crypt
mke2fs 1.44.5 (15-Dec-2018)
Creating filesystem with 497664 1k blocks and 124440 inodes
Filesystem UUID: cce88557-9c08-4039-94f6-0940522cd0ce
Superblock backups stored on blocks: 
        8193, 24577, 40961, 57345, 73729, 204801, 221185, 401409

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 
```

## Mount /boot and /boot/efi and restore the /boot backup
```text
root@quanah ~ # mount -v /boot
mount: /dev/mapper/boot_crypt mounted on /boot.
root@quanah ~ # tar -C /boot --acls --xattrs -xf /tmp/boot.tar
root@quanah ~ # mount -v /boot/efi
mount: /dev/nvme0n1p1 mounted on /boot/efi.
root@quanah ~ # 
```

## Make GRUB able to decrypt /boot

```text
root@quanah ~ # echo "GRUB_ENABLE_CRYPTODISK=y" >>/etc/default/grub
root@quanah ~ # update-grub
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-4.19.0-14-amd64
Found initrd image: /boot/initrd.img-4.19.0-14-amd64
Adding boot menu entry for EFI firmware configuration
done
root@quanah ~ # grub-install /dev/nvme0n1 
Installing for x86_64-efi platform.
Installation finished. No error reported.
```

Verify that GRUB now has `cryptodisk` support:
```text
root@quanah ~ # grep cryptodisk /boot/grub/grub.cfg
        insmod cryptodisk
                insmod cryptodisk
                insmod cryptodisk
```

```text
root@quanah ~ # cryptsetup luksChangeKey --pbkdf-force-iterations 500000 /dev/nvme0n1p2
Enter passphrase to be changed: 
Enter new passphrase: 
Verify passphrase: 
```

## Find key slot for `/`
```text
root@quanah ~ # cryptsetup luksOpen --test-passphrase --verbose /dev/nvme0n1p3
Enter passphrase for /dev/nvme0n1p3: 
Key slot 0 unlocked.
Command successful.
```

## Avoid password prompt for /
```text
root@quanah ~ # mkdir -m0700 /etc/keys
root@quanah ~ # ( umask 0077 && dd if=/dev/urandom bs=1 count=64 of=/etc/keys/root.key conv=excl,fsync )
64+0 records in
64+0 records out
64 bytes copied, 0.00466466 s, 13.7 kB/s
root@quanah ~ # cryptsetup luksAddKey /dev/nvme0n1p3 /etc/keys/root.key
Enter any existing passphrase: 
```

Find the keyslots used
```root@quanah ~ # cryptsetup luksDump /dev/nvme0n1p3 | grep ^Keyslots: -A 20
Keyslots:
  0: luks2
        Key:        512 bits
        Priority:   normal
        Cipher:     aes-xts-plain64
        Cipher key: 512 bits
        PBKDF:      argon2i
        Time cost:  4
        Memory:     616640
        Threads:    4
        Salt:       3d ab 5d d1 13 ed 6d ee 8d a9 49 3a 6f 97 f1 d3 
                    01 d1 16 bd 87 bf cf a5 13 54 65 b2 86 e4 6f c3 
        AF stripes: 4000
        AF hash:    sha256
        Area offset:32768 [bytes]
        Area length:258048 [bytes]
        Digest ID:  0
  1: luks2
        Key:        512 bits
        Priority:   normal
        Cipher:     aes-xts-plain64
        Cipher key: 512 bits
        PBKDF:      argon2i        
```

Speed up the finding of the right key when unlocking `/`;
```
root@quanah ~ # cat /etc/crypttab
nvme0n1p3_crypt UUID=ad321585-fba2-478f-a58f-5e7c8f9f8b24 none luks,discard,key-slot=1
boot_crypt UUID=feb776d4-47ed-4dc0-83a3-cd0788cec7f6 none luks
```

Edit it so that instead of `none` in the third column on the
`nvme0n1p3_crypt` (for the `/` partitiion), it says:

```
root@quanah ~ # cat /etc/crypttab 
nvme0n1p3_crypt UUID=ad321585-fba2-478f-a58f-5e7c8f9f8b24 /etc/keys/root.key luks,discard,key-slot=1
```

## Regenerate the kernel image with the key inside
```text
# echo "KEYFILE_PATTERN=\"/etc/keys/*.key\"" >>/etc/cryptsetup-initramfs/conf-hook
# echo UMASK=0077 >>/etc/initramfs-tools/initramfs.conf
```

```text
root@quanah ~ # update-initramfs -u
update-initramfs: Generating /boot/initrd.img-4.19.0-14-amd64
root@quanah ~ # stat -L -c "%A  %n" /initrd.img
-rw-------  /initrd.img
```

Verify that the key is inside:
```
root@quanah ~ # lsinitramfs /initrd.img | grep cryptroot/keyfiles
cryptroot/keyfiles
cryptroot/keyfiles/nvme0n1p3_crypt.key
```

## Add key for the /boot partition as well

```text
root@quanah ~ # ( umask 0077 && dd if=/dev/urandom bs=1 count=64 of=/etc/keys/boot.key conv=excl,fsync )
64+0 records in
64+0 records out
64 bytes copied, 0.00735171 s, 8.7 kB/s
root@quanah ~ #  cryptsetup luksAddKey /dev/nvme0n1p2 /etc/keys/boot.key
Enter any existing passphrase: 
root@quanah ~ # 

```


## Performance

Compiling a Maven project consisting of Maven modules and Java files
on my an i7 CPU with 16GB RAM takes:

