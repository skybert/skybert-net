title: Video Editing on Linux
date: 2016-06-08
category: linux
tags: linux, video



<a href="/graphics/2016/2016-06-08-video-editing-on-linux.png">
  <img src="/graphics/2016/2016-06-08-video-editing-on-linux.png"
    class="centered"
    alt="video editing on linux"
    style="width: 800px; "
  />
</a>

These are the tools I use on to record screencasts, record sound,
combine the two, edit the video and create the final result.

## Capture video

I use the excellent and extremely powerful command line tool
[ffmpeg](https://ffmpeg.org/):

```
$ ffmpeg -video_size 1920x1200 \
  -framerate 25 \
  -f x11grab \
  -i :0.0+1920,0 \
  ~/video/my-video.mp4
```

## Record sound

Earlier, I recorded the sound at the same time as the video. This was
incredibly hard, to both type and talk at the same time. Also,
the sound of me typing on the keyboard as well as the laptop fan got
onto the sound track, which was far from ideal. For these reasons,
recording the video and sound separately is a much better solution,
albeit a more time consuming one.

I use an external microphone and use the Pulse Audio Control dialogue,
started with the `pavucontrol` command, to choose the input device to
use as default. This is needed cause GNOME Sound recorder assumes the
default recording device.

The
[GNOME Sound recorder](https://wiki.gnome.org/Design/Apps/SoundRecorder),
started with the `sound-sound-recorder` command is blissfully simple
to use. I just go with the default which gives me audio files in Ogg
Vorbis format.

## Edit video

For editing video, I've used
[OpenShot](http://www.openshotvideo.com/). It's easy enough for me to
understand and provides non linear editing, multiple tracks, export of
various video formats and so on.

One thing I found important, was to select a high enough resolution
for the text in my screencast was clear and sharp in the end
result. For this, I chose a similar resolution and frame rate to what
I passed to `ffmepg` when recording the video.

## Publishing your video

Both [Vimeo](http://vimeo.com) and [Youtube](http://youtube.com) will
serve you well here.

## Conclusion

Creating screencasts, recording sound and video works fairly well on
Linux, at least for casual users like myself 😊
