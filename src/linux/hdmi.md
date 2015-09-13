title: Playing Video Files on a TV through HDMI on Linux
date: 2015-09-11
category: linux
tags: linux, video, hdmi

## Finding the TV 📺

First off, I had to figure out which device my TV connected through my
HDMI cable was identified as on my Debian Linux machine.

To figure out this, I used the `aplay` command which comes with the
`alsa-utils` package:

```
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: CX20751/2 Analog [CX20751/2 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

As you can see, there are two cards. `card 0` is the external HDMI
connection to my TV. On that card, there are two devices, `device 3`
and `device 7`. `card 1` is the internal device (HDA Intel PCH), which
oddly enough isn't the first card listed.

## Telling mplayer to play the video on the TV 🎥

HDMI carries both video and sound, so after finding the correct ALSA
card and device, I asked `mplayer` to channel both video and audio
onto the TV by using the `-ao` switch like this:

    $ mplayer -ao alsa:device=hw=0.7 video.mp4

I didn't know whether or not device 3 or 7 would be the right ones, so
I just tried both 😃 Once that was out of the way, the video played
flawlessly on my 52" TV with no noticeable lag in neither audio nor
video.


