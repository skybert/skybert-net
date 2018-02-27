title: Making top look nice
date: 2017-11-28
category: linux
tags: linux, top

All Linux distros ship with the utility `top` from
[procps](https://gitlab.com/procps-ng/procps). It is really useful,
but not as appealing as that of the likes of
[htop](http://hisham.hm/htop/).

<img
    class="centered"
    alt="top orig"
    src="/graphics/2017/top-default.png"
/>

After using `top` for 17-18 years, I discovered that it's possible to
tweak the appearance of it. My `top` now lists CPU load per core, it
has graphical bars for representing memory and CPU usage, it lists
complete commands with options and it even has 8 colours to choose for
4 targets! (the lesson as always is to
[RTFM](http://man7.org/linux/man-pages/man1/top.1.html)).

<img
    class="centered"
    alt="top tweaked"
    src="/graphics/2017/top-tweaked.png"
/>

My [.toprc can be found
here](https://github.com/skybert/my-little-friends/blob/master/top/.toprc).

Happy monitoring!
