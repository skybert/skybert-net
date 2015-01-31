title: Getting APT to use IPv4 instead of IPv6
category: linux
tags: linux, debian
date: 2015-01-31

Edit ```/etc/gai.conf``` and uncomment the line (54 on my system) that reads:

    precedence ::ffff:0:0/96  100

And you're all set. ```apt-get``` will instantly pick up the change
and use IPv4 instead of IPv6.

