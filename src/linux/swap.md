date:    2012-10-07
category: linux
tags: linux
title: Swap Space

## Getting the Size Right

I've heard and read many arguments over the years about the
correct amount of swap space on Linux. The requirement and
reality has changed a lot for swap over time and <a
href="http://etbe.coker.com.au/2007/09/28/swap-space/">this
article is the best I've read</a> summarising it all in a
convincing manner.


The short conclusion from this article is:

```java
swap = 2GB;

if (ram <= 1GB) {
  swap = ram;
}
else if (ram < 4GB) {
  swap = ram / 2;
}
```

## Adding a Swap File

I love the simplicity with which you can add and remove swap files in
runtime. This is how I added a 1GB swap file, adding an entry for it
to```/etc/fstab``` and activating it:

```text
# dd if=/dev/zero of=/var/lib/swap.file bs=1024 count=1024000
# mkswap /var/lib/swap.file
# echo "/var/lib/swap.file swap swap defaults 0 0" >> /etc/fstab
# chmod 0600 /var/lib/swap.file
# swapon -a
```

That's it. Running```free -m``` shows that I now have 1GB swap
available. There's no greatness where there's no simplicity. And Linux
is full of such simplicity :-)

