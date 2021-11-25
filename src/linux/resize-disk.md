title: Resizing a disk 
date: 2021-11-11
category: linux
tags: linux


First off, check the status of the `/` partition that we want to give
more space:

```text
# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda4       144G   70G   67G  52% /
```

We've then expanded the disk on the hosting platform (Linode, AWS, KVM++) and want to make use of that extra space. For this, we use the partition tool GNU Parted: 


```text
# parted /dev/sda
GNU Parted 3.2
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Warning: Not all of the space available to /dev/sda appears to be used, you can fix the GPT to use all of the space (an extra 734003200 blocks) or continue with the current setting?
Fix/Ignore? Fix
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 537GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system     Name  Flags
 1      1049kB  2097kB  1049kB                        bios_grub
 2      2097kB  1076MB  1074MB  ext4
 3      1076MB  3223MB  2147MB  linux-swap(v1)
 4      3223MB  161GB   158GB   ext4

(parted) resizepart 4
Warning: Partition /dev/sda4 is being used. Are you sure you want to continue?
Yes/No? yes
End?  [161GB]? 537GB
```

Now we can ask `parted` to print the new partition table to verify
it's what we'd expect it to be:

```text
(parted) p
Model: VMware Virtual disk (scsi)
Disk /dev/sda: 537GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system     Name  Flags
 1      1049kB  2097kB  1049kB                        bios_grub
 2      2097kB  1076MB  1074MB  ext4
 3      1076MB  3223MB  2147MB  linux-swap(v1)
 4      3223MB  537GB   534GB   ext4

(parted) q
Information: You may need to update /etc/fstab.
```

## Resize the file system to use the new space

```text
# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda4       144G   70G   67G  52% /
```

Then resize it:
```text
# resize2fs /dev/sda4
resize2fs 1.44.1 (24-Mar-2018)
Filesystem at /dev/sda4 is mounted on /; on-line resizing required
old_desc_blocks = 19, new_desc_blocks = 63
The filesystem on /dev/sda4 is now 130285051 (4k) blocks long.
```

Now, verify that the space is actually used as intended:
```text
# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda4       489G   70G  397G  15% /
```

Now that's a much larger disk!

## Checking /etc/fstab

```text
# cat /etc/fstab
UUID=86935d45-9ba5-11e8-877f-0050569be994 none swap sw 0 0
UUID=87b2c106-9ba5-11e8-877f-0050569be994 / ext4 defaults 0 0
UUID=86935d44-9ba5-11e8-877f-0050569be994 /boot ext4 defaults 0 0
```

Verify that the UUID of the `/` partition that we resized somehow hasn't changed:
```text
# blkid | grep sda4
/dev/sda4: UUID="87b2c106-9ba5-11e8-877f-0050569be994" TYPE="ext4" PARTUUID="09fa4b97-c549-44d6-b498-a3117264b445"
```

As you can see, the `UUID` corresponds to what it's in `/etc/fstab`.


