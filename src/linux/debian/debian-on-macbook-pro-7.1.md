date:    2012-10-07
category: linux
tags: debian
title: Installing Debian on Macbook Pro 7,1

Installing Debian on my Macbook Pro 7,1 was a rocky road, so I
thought I'd sare some of the details how I got it all
working.

<a href="http://picasaweb.google.com/lh/photo/up7ibCI_ZvgYer-erAtHaA?feat=directlink">
<img src="http://lh5.ggpht.com/_xP7IZ-JRNDI/TShOKfWDYvI/AAAAAAAAP4w/vReWHCxRVAs/s288/IMG_3170.JPG"
alt="After some fiddling, I got the installer running ..."
/>
</a>
<a href="http://picasaweb.google.com/lh/photo/E48oK7VIur-gM2XIJFpW9A?feat=directlink">
<img src="http://lh4.ggpht.com/_xP7IZ-JRNDI/TShOUoKxXpI/AAAAAAAAP44/9_cbbQbpPI4/s288/IMG_3173.JPG"
alt="...and some hours later, I got Debian up and running"
/>
</a>

Part of the difficulty of installing Debian on my Macbook Pro (in
January 2010) is that the various documentation, wiki pages, mailing
list posts and blog entries available online is very sketchy,
contradicting and to a great degree outdated. For instance, I was very
confused as what to do about booting &amp; partioning. Do I need
Bootcamp? What about rEFIt? Do I have to use the rather ancient LILO
instead of Grub? And so on.

## Partitioning

I simply used the default partition tool installed on my Mac. Shrunk
the Mac partition and added a second one of type FAT.


Later, when I was in the Debian installer, I re-formatted this
partition as EXT3 (I tried EXT4 first, but this failed for some
reason). I didn't set up a swap partition as I don't believe I need it
with 4GB RAM. If needs be, I'll set up a swap file (not a partition)
later on.

## Installing new boot loader

I installed the <a href="http://refit.sourceforge.net/">rEFIt</a> Mac
package, which both provided me with a boot loader which detects
various OSes, allows you to boot them (including Linux) and syncs
between the Mac specific partition table and the "real" partition
table. This tool, accessible from the boot menu, is necessary to run
after you install Debian (or Linux in general).

## Do I need Bootcamp?

I've read about that you need to use Bootcamp, I don't believe this to
be true. The only thing I used it for, was basically to launch the
"Windows installer", which I believe to be the same as restarting your
computer and pressing the ```c``` key to boot from the CD drive.

## Use a modified version of the Debian Lenny installer

I tried the latest (2011-01-07) builds of the Debian Squeeze and none
of them managed to find the CDROM drive (even though the installer was
launched from it!).


Using this <a
href="http://www.nigauri.org/~iwamatsu/trash/lenny-custom-0722.iso">version
of the Lenny installer from iwamatsu</a>, the installer worked
perfectly (except for failing to use EXT4, forcing me to use
EXT3 instead).


One thing you must be careful to do, is to install GRUB to
your Linux partition and <em>not</em> to the device's
MBR. This is <strong>very important</strong>, or else, you
might not be able to boot the rEFIt loader when you start the
computer. The idea is that you first boot rEFIt and when
selecting Linux, rEFIt will call the GRUB boot loader located
on the Linux partition.

## Wireless
    02:00.0 Network controller: Broadcom Corporation BCM4322
    802.11a/b/g/n Wireless LAN Controller (rev 01)


To get wireless working, I had to manually compile the```wl``` driver
as well as black listing the```b43``` and ```ssb``` kernel modules.


It's important that you first unload the```b43``` and```ssb``` driver
before you attempt to load the```wl``` driver, as the latter will not
work properly (although it will load) if the other drivers are
present. To do this manually, do:

    # rmmod ssb
    # rmmod b43
    # modprobe lib80211_crypt_tkip
    # modprobe wl


Once this is working properly for you, you can make this
persistent with:

    # echo lib80211_crypt_tkip &gt;&gt; /etc/modules
    # echo wl &gt;&gt; /etc/modules
    # echo "blacklist b43" &gt;&gt; /etc/modprobe.d/blacklist.conf
    # echo "blacklsit ssb" &gt;&gt; /etc/modprobe.d/blacklist.conf

## Keyboard summarsaults

Since the Mac keyboard is different (some will say inferiour
to that of a normal PC keyboard), I had to make some
modifications to my keymap as well as learning a few new
tricks.

### Chaning around some vital keys
<p>I got back the keyboard comfort by creating this
```.xmodmaprc```:

I load it by putting this in my```.fluxbox/startup```
file:

    xmodmap "$HOME/.xmodmaprc"

### Where is the insert key?

I use the insert key all the time for pasting text
(```shfit + insert```), to get the insert key press on
the Mac keyboard, I had to do```fn + enter```, normal
X paste then became```fn + shift + enter```

## That icy touchpad

The touch pad is really nice (although I would wish for a
track point instead), but requires some fiddling to get
working properly.

### How do I right click?

The touch pad left somethings to be learned. To right click, I
tap (click) with two fingers.

### Multi touch

To get multitouch to work, I installed the following packages
from the Debian testing repository:

    # apt-get install xserver-xorg-input-multitouch libmtdev1


As well as the kernel module specific for this touch pad. Add
<a href="http://bitmath.org/code/mactel/">the Mactel
repository</a> to your```/etc/apt/sources.list``` and:

    # apt-get install bcm5974-dkms


This will also install the HID package you need.

<blockquote>
Important, do <strong>not</strong> install the
```
xf86-input-multitouch``` from the above Ubuntu Mactel
repostiroy as it's binary incompatible with the X server
installed from the Debian repository, since they've been
compiled against differnet versions of the X server.
</blockquote>

I added the following snippet to my```org.conf```

    Section "InputClass"
    MatchIsTouchpad "true"
    Identifier "Multitouch Touchpad"
    Driver "multitouch"
    EndSection

## Shiny graphics

Currently, I couldn't get X working properly with the open
source alternatives for nVIDIA, hence I needed the
properiatary driver:

    # apt-get install nvidia-glx nvidia-kernel-dkms \
      nvidia-kernel-source nvidia-settings nvidia-xconfig

## Screen Brightnes

I had the problem that after waking up from its sleep (suspend
to RAM), the brightness was dimmed down if the laptop wasn't
plugged in. Even after plugging it in, it was not possible to
get the brightness up. This problem did not occur when doing a
normal, cold boot of the Mac.


The solution was to install <a
href="https://github.com/guillaumezin/nvidiabl">guillaumezin's
nvidiabl</a> kernel driver. I installed it from source and
SUIDed the executable and set myself to the group owner of the
brighness device. It's probably more "correct" to hook onto
the APCI event structure in```/etc/acpi```, but I just
wanted it to work <em>now</em> so that I could continue my
work.

First off, this meant:
    $ cd /usr/local/src
    $ git clone https://github.com/guillaumezin/nvidiabl.git
    $ cd nvidiabl
    $ make
    $ su -
    # make install
    # cp srcipts/etc/* /etc/
    # cp srcipts/usr/local/sbin/* /usr/local/sbin


I then made it possible for the```torstein``` user to
set the brightness without the way of ACPI events:

    # chgrp torstein /sys/class/backlight/nvidia_backlight/brightness
    # chmod g+w /sys/class/backlight/nvidia_backlight/brightness
    # chmod 755 /usr/local/sbin/nvidiablctl


Lastly, I bound the key events of the brightness keys to the
nvidiablctl script using my window manager's
configuration. Since I'm using fluxbox, this meant adding the
following lines to```~/.fluxbox/keys```:

    # Brightness
    XF86MonBrightnessDown :ExecCommand /usr/local/sbin/nvidiablctl down
    XF86MonBrightnessUp :ExecCommand /usr/local/sbin/nvidiablctl up

## Microphone

I had problems getting the microphone to work in Skype and
Google Video (even though it worked
in```gnome-sound-recorder```). Simply
installing```pulseaudio``` made it work in Skype too.

    $ lspci | grep audio
    00:08.0 Audio device: nVidia Corporation MCP89 High Definition Audio (rev a2)
    $ dpkg -l pulseaudio | grep ^ii
    ii  pulseaudio     0.9.21-3+squeeze1    PulseAudio sound server

### Let go of my sound card!

Sometimes, I've had the problem that some process have
"stolen" my sound card. This is especially a problem when I
want to talk on Skype or Google Talk (voice/video). Hence,
when I don't get any sound or microphone working, I run this
wee script to make the other applications "let go" of my sound
card:

    #! /usr/bin/env bash
    lsof +d /dev/snd/ | \
      grep -v pulse | \
      grep -v COMM | \
      cut -d' ' -f5 | \
      xargs kill -9

## Working on the same files

Since I'm working on the same files on Linux from Mac OS X and
wise verca, I have changed the UID of the Linux user to match
that of the Mac user.

    # /etc/passwd
    torstein:x:502:1000:Torstein Krause Johansen,,,:/home/torstein:/bin/bash


Debian asisgned user ID```1000``` to my ```torstein``` user, whereas
Mac OS assigned ID```502``` to its ```torstein``` user. For the
permissions and everything to look right when visiting the same files
from either operating system, I changed the UID of my user in Debian,
as shown above.

## On the Mac OS X side of things

Added this to my```.bashrc``` which again is called
each time I open a new terminal. This is something you must
configure for the Terminal application, per default it doesn't
source```.bashrc```

    if [ $(df | grep debian | wc -l) -lt 1 ]; then
      sudo fuse-ext2 /dev/disk0s3 /mnt/debian/ -o force,rw
    fi

