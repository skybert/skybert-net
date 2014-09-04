date:    2012-10-07
tags: debian
category: linux
title: /etc/apt/sources.list

These are the sources I'm using on most of my Debian boxes:

```
# Torstein's sources.list                                    -*- sh -*-
#######################################################################
# stable
#######################################################################
deb http://security.debian.org/ stable/updates main contrib non-free
deb-src http://security.debian.org/ stable/updates main main contrib non-free

deb http://ftp.no.debian.org/debian/ stable main contrib non-free
deb-src http://ftp.no.debian.org/debian/ stable main

deb http://volatile.debian.org/debian-volatile stable/volatile main contrib non-free
deb-src http://volatile.debian.org/debian-volatile stable/volatile main contrib non-free

#######################################################################
# testing
#######################################################################
# deb http://security.debian.org/ testing/updates main contrib non-free
# deb-src http://security.debian.org/ testing/updates main main contrib non-free

# deb http://ftp.no.debian.org/debian/ testing main contrib non-free
# deb-src http://ftp.no.debian.org/debian/ testing main

#######################################################################
# opera
#######################################################################
deb http://deb.opera.com/opera/ stable non-free

#######################################################################
# google
#######################################################################
deb http://dl.google.com/linux/deb/ stable non-free main

#######################################################################
# Percona repository
#######################################################################
deb http://repo.percona.com/apt lenny main
deb-src http://repo.percona.com/apt lenny main

#######################################################################
# mplayer etc
#######################################################################B
deb http://www.debian-multimedia.org squeeze main

```


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
