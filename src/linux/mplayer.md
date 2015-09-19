title: MPlayer
date: 2015-09-17

## Playing a directory as a DVD

If you've made a backup of your DVD with e.g. `dvdbackup`, you can
play the directory like a regular DVD like this:

```
$ mplayer dvd:// -dvd-device ~/video/dvd-directory-containing-VIDEO_TS
```

## Channeling audio to your TV using ALSA

This is how I tell `mplayer` to play a video on my HDMI connected TV:

```
$ mplayer -ao alsa:device=hw=0.7 file.mp4
```

The correct values is found via the output from `aplay -l`.
