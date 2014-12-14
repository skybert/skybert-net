date:    2012-10-07
tags: debian
category: linux
title: /etc/apt/sources.list

This is the
[/etc/apt/sources.list](https://github.com/skybert/my-little-friends/blob/master/debian/sources.list)
I'm using on most of my Debian boxes.

As I often also add sources from both table and testing (and sometimes
unstable and even experimental), I also have
[APT pinning](http://jaqque.sbih.org/kplug/apt-pinning.html) set up
[in /etc/apt/preferences](https://github.com/skybert/my-little-friends/blob/master/debian/preferences).



## Adding the third party repository keys

I trust these third party sources, therefore I add their keys
to my local APT key ring:

### debian-multimedia.rg
    # apt-get install keydebian-multimedia-keyring

### opera.com
    # wget -O - http://deb.opera.com/archive.key | apt-key add -

### skype.com
    # apt-key adv --keyserver pgp.mit.edu --recv-keys 0xd66b746e

### percona.com
    # apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

<!--
### mozilla.debian.net
    wget -O - -q http://mozilla.debian.net/archive.asc | gpg --import

-->
