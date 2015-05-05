date:    2012-10-07
category: linux
tags: linux, alsa
title: Getting USB Headset With Microphone To Work

I set this up in my local ALSA configuration to make it work probably
with the external USB headset:

```
# $HOME/.asoundrc
pcm.usb-audio {
  type plug
  slave.pcm "hw:1"
}

ctl.usb-audio {
  type hw
  card 1
}

pcm.!default {
  type hw
  card Headset
}

ctl.!default {
  type hw
  card Headset
}

```

The name "Headset", I got by looking at the output from:

    $ cat /proc/asound/cards
    0 [Intel          ]: HDA-Intel - HDA Intel
    HDA Intel at 0xfebfc000 irq 21
    1 [Headset        ]: USB-Audio - Logitech USB Headset
    Logitech Logitech USB Headset at

Now, the audio and microphone works both in [Skype](http://skype.com)
and other places, like [XMMS2](http://xmms2.org).

