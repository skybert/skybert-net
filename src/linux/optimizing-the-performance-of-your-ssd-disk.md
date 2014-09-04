date:    2012-10-07
category: linux
title: Optimising the Performance of Your SSD Disk

First, find out if your drive supports the <a
href="http://en.wikipedia.org/wiki/TRIM">TRIM</a> extension:

    # hdparm -I /dev/sda1 | grep TRIM
       *    Data Set Management TRIM supported (limit 8 blocks)
       *    Deterministic read data after TRIM


Then, make sure you're using ext4 or btfs file system and the
following parameters to your```/etc/hosts``` for your
SSD disks:

    # vi /etc/fstab


My old configuration looked like this. This is the default set
up if you run through the Debian installer (2012-08-09 09:45,
for readability, I've replaced the UUID with the actual disk
drive, for you it might be some UUID gibberish like:
UUID=89ee37b9-c00e-445e-9350-0e1e5f124275)

    /dev/sda1 / ext4 errors=remount-ro 0 1


Then, add the```discard``` and
```noatime```
parameters:

    /dev/sda1 / ext4 errors=remount-ro,discard,noatime 0 1


The```discard``` parameter should make use of the TRIM
extension and ensure that your SSD disk performs (almost)
equally well when it gets older as it did when it was new.


The```noatime``` is a safe performance parameter
regardless of SSD or not, you might have read about it before,
it's been there for a long time and works on other file
systems too, like```ext3```


Finally, remount your partition (there's no need to reboot
it):

    # mount -o remount /dev/sda1


You should now see increased hard disk performance, especially
as the SSD drive gets older (the```discard``` should
work wonders here). You can test the hard drive performance by
running```hdparm``` multiple times with and without
the parameters set:

    # for i in {0..5}; do hdparm -Tt /dev/sda1 ; done

## My machines

As a reference and yard stick(s), you can have a look at the
number of some of my machines:

### 128GB Crucial m4 2.5-inch SATA 6Gb/s (Model number: M4-CT128M4SSD2)


Mount options:

    $ mount | grep " on / " | cut -d' ' -f3-
    / type ext4 (rw,relatime,errors=remount-ro,user_xattr,commit=600,barrier=1,data=ordered,discard)


Performance:

```
# for i in {0..5}; do hdparm -Tt /dev/sda1 ; done
[..]
/dev/sda1:
Timing cached reads:   14160 MB in  2.00 seconds = 7085.00 MB/sec
Timing buffered disk reads: 1214 MB in  3.00 seconds = 404.49 MB/sec

/dev/sda1:
Timing cached reads:   14092 MB in  2.00 seconds = 7051.14 MB/sec
Timing buffered disk reads: 1216 MB in  3.00 seconds = 405.29 MB/sec

/dev/sda1:
Timing cached reads:   14238 MB in  2.00 seconds = 7123.76 MB/sec
Timing buffered disk reads: 1212 MB in  3.00 seconds = 403.98 MB/sec

/dev/sda1:
Timing cached reads:   12386 MB in  2.00 seconds = 6196.75 MB/sec
Timing buffered disk reads: 1214 MB in  3.01 seconds = 403.99 MB/sec

/dev/sda1:
Timing cached reads:   13762 MB in  2.00 seconds = 6885.45 MB/sec
Timing buffered disk reads: 1216 MB in  3.00 seconds = 405.21 MB/sec

/dev/sda1:
Timing cached reads:   13576 MB in  2.00 seconds = 6792.06 MB/sec
Timing buffered disk reads: 1210 MB in  3.00 seconds = 403.02 MB/sec

```
