title: Spotify on the Linux command line
date: 2017-06-22
category: linux
tags: linux, music, spotify

The [Spotify](http://spotify) Linux desktop client can easily be
controlled from the command line through the standard messaging bus on
Linux, [DBUS](https://dbus.freedesktop.org/doc/dbus-tutorial.html).

Here are the commands I'm using. Of course, I've wrapped these in more
user friendly BASH functions, which again I've hooked up to desktop
shortcuts, but since you're likely to use a different desktop
environment than I or you want to roll your own integration, these are
the lower level commands that you need.

Happy listening! 𝅘𝅥𝅯

## Toggle play/pause state
```
$ dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.PlayPause
```

## Skip to the next song in the play list

```
$ dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Next
```

## Play the previous song in the play list

```
$ dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Prev
```

## Getting information about the current song

```
$ qdbus \
  --literal org.mpris.MediaPlayer2.spotify \
  /org/mpris/MediaPlayer2 \
  org.freedesktop.DBus.Properties.Get \
  org.mpris.MediaPlayer2.Player \
  Metadata 
```
 
