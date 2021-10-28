title: Fixing Blury Rendering in Kdenlive
date: 2021-09-28
category: linux
tags: linux, video

Many people, including me, have problems with `kdenlive` producing
blury videos. This is how I solved it.

The original video had this encoding:
```text
$ mpv foo.mp4
 (+) Video --vid=1 (*) (h264 2560x1440 25.000fps)
 (+) Audio --aid=1 (*) (aac 2ch 48000Hz)
AO: [pulse] 48000Hz stereo 2ch float
VO: [gpu] 2560x1440 yuv444p
(Paused) AV: 00:00:09 / 00:45:36 (0%) A-V:  0.000
```

It's then important to choose a rendering profile with the same:
- `2560x1440` screen resolution
- `25` frames per second
- A codec that doesn't ruin everything (the original used H264)

I first choose WebM, which produced blury output even though the
resolution and FPS were correct. I then chose the one called `MP4`,
which had the following options if I double clicked on it:

```text
f=mp4
movflags=+faststart
vcodec=libx264
progressive=1
g=15
bf=2
crf=%quality
acodec=aac
ab=%audiobitrate+'k'
```

The video codec `libx264` sounded quite similar to `h264` that `mpv`
listed when playing the original, so I wagered this being a good bet.

And lo and behold, it was! The rendered video turned out sharp and
crisp.

Happy rendering!


