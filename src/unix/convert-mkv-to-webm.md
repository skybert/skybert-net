title: Convert mkv to webm
date: 2023-05-05
category: unix
tags: unix


To convert [Matroska video
files](https://en.wikipedia.org/wiki/Matroska) (`.mkv`), to [WebM
video files](https://en.wikipedia.org/wiki/WebM) (`.webm`), I've found
that this command produces good results:

```
$ ffmpeg -i foo.mkv -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis foo.webm
```

The resulting `foo.webm` video file plays natively in Firefox and
Google Chrome, as well as standalone video players like [mpv](mpv.io)
