date: 2010-07-27
category: linux
tags: linux, x
title: Xinerama

This is what I did to get <a
href="http://en.wikipedia.org/wiki/Xinerama">Xinerama</a>
working. I've got one laptop with a wide screen display and an
external monitor with normal 4:3 aspect ratio.

Furthermore, I'm using the free, open source video drivers (for my
nVIDIA card), so I cannot use their nice GUI for setting it up. On the
other hand, this approach will work for all kinds of video cards, so
read on!

## Using xrandr to set make use of the two screen

This sets up the external screen to the right of my laptop
screen, positioning on the pixel by giving the resolution
of the laptop screen.

    $ xrandr  --output VGA1 --right-of LVDS --pos 1440x900 --auto

When I disconnect the external screen, I do the following to
get all the windows on the external screen onto the laptop
screen:


    $ xrandr  --output VGA1 --off

Of course, I've added these lines to
my```.xinitrc``` to set this up automatically when I
start my computer :-)


## Using xrandr to set make use of two screens with different orientation

This is the command I use to set up my external screen to
the right of my laptop screen. My external screen I've set
to display in portrait orientation whereas the laptop
screen has the default landscape orientation.

    $ xrandr --output VGA-1 --right-of LVDS-1 --auto --rotate left

## Changes to the X configuration

<div class="note">
  Update 2010-07-27 11:31: I no longer need to make these changes
  to```xorg.conf``` to get xinerama working (using the```nouveau```
  rather than the ```nv``` driver, both of which are open source and
  free).
</div>

Versions of related software:

- ```libdrm-nouveau1 2.4.18-6```
- ```libxrandr2 2:1.3.0-3```
- ```xorg 1:7.5+6```
- ``` xserver-xorg-video-nouveau 1:0.0.15+git20100329+7858345-4```


You need to enter the full view area to your```/etc/X11/xorg.conf```,
adding up the resolutions of the two screens, as reported by
the```xrandr -q``` command.

```
Section "Screen"
Identifier     "Screen0"
Device         "Device0"
Monitor        "Monitor0"
DefaultDepth    24
SubSection     "Display"
Depth       24
    #  1440+1600  900+1200
Virtual     3040 2100
EndSubSection
```


