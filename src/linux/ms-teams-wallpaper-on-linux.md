title: MS Teams Wallpaper on Linux
date: 2021-10-06
category: linux
tags: linux, video

My only envy of Mac and Windows users has been video backgrounds in
[Microsoft
Teams](https://www.microsoft.com/nb-no/microsoft-teams/). Not any
more, thanks to [backscrub](https://github.com/floe/backscrub).

<a href="/graphics/2021/2021-10-07-teams-with-wallpaper.jpg">
  <img
    class="centered"
    src="/graphics/2021/2021-10-07-teams-with-wallpaper.jpg"
    alt="teams with wallpaper"
    style="width: 1024px"
  />
</a>  

You'll need to compile it yourself (which will also compile
Tensorflow).

```bash
$ git clone https://github.com/floe/backscrub.git
$ mkdir build
$ cd build
$ cmake .. && make -j$(nproc)
```

Then, load the kernel module:

```text
# modprobe v4l2loopback \
  devices=1 \
  max_buffers=2 \
  exclusive_caps=1 \
  card_label="VirtualCam" \
  video_nr=10
```

You'll then be able to choose your background with:

```bash
$ ./build/backscrub \
      -c /dev/video0 \
      -v /dev/video10 \
      -b ~/pictures/wallpapers/foo.jpg
```

In Chrome/Teams/Skype++ you'll then choose `/dev/video10`, which will
show up as `VirtualCam` because of the `card_label` option to
`modprobe` above, instead of `/dev/video0` as the camera input. That's
it.

...well, there is actually another thing you must do: Currently
(2021-10-06), the `eigen` library is down on Gitlab, so before running
`cmake`, you'll have to do:

```bash
$ find -type f | 
  while read -r f ; do 
    sed 's#https://gitlab.com/libeigen/eigen#https://gitlab.com/libeigen/eigen-backup#g' "$f"; 
  done
```
    
Thanks to `backscrub`, I no longer have a thing I miss on Linux ;-)
