title: Netflix on Debian Wheezy 64bit
date:    2013-01-06
tags: debian
category: linux

<img src="netflix-running-on-debian-wheezy.png" alt="netflix on
debian" style="float: right;"/>

Thanks to <a href="http://ppa.launchpad.net/ehoover/compholio/ubuntu">
ehoover's excellent packages</a> and the grandness of <a
href="http://www.winehq.org/">Wine</a> and other good forces of the
Linux world, I got Netflix up and running on my 64 bit Debian Wheezy
box yesterday.


The mentioned packages are made for Ubuntu, so there were a few
caveats. I got pretty far thanks to this <a
href="http://crunchbang.org/forums/viewtopic.php?pid=281492">great
thread on the Crunchbang forums</a>, but had to do a wee bit more,
hence this article.

First off, my system is 64bit, so I couldn't use the packages for the
suggested quantal as these were (at the time of writing) only
available for 32bit. Of course, I could add i386 as an additional
architecture, but I didn't want to go there, hence I used the packages
from oneiric instead.

## Getting the netflix and custom wine packages

I added this to my```/etc/apt/sources.list```:

    deb http://ppa.launchpad.net/ehoover/compholio/ubuntu oneiric main

I could then install the```netflix-desktop``` package, as well as
the```ttf-mscorefonts-installer```:

    # apt-get install netflix-desktop ttf-mscorefonts-installer

## Getting the required Windows fonts

For some reason, I had to re-run the font installer after setting the
EULA selection (I had already run the installer and accepted the EULA
long time ago):

    # echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
    # apt-get install --reinstall ttf-mscorefonts-installer

## Running the netflix-desktop post-install hooks

When running```netflix-desktop``` for the first time,
it attempts to download some additional binaries, however,
this didn't work on my system as it insists on using
```sudo``` and since I'm not using this, it keeps on
failing. The remedy was easy, though:

    # cd /usr/share/netflix-desktop
    # ./download-missing-files
    # ./install-fonts

## Performance & conclusion

Netflix runs pretty well on my system. It does lag sometimes, but I
see that it does this under Windows too, so I assume that's because of
the internet connection.


As a yard stick, you may find it useful to know that I'm running
Debian Wheezy, kernel 3.2.0-2-amd64, have 8GBs of RAM and an Intel
i7-2640M 2.8 GHz CPU.


I've now watched two full length films and am very satisfied running
Netflix on my Debian system. Thanks again to everyone in the community
that has made this possible!

