date:    2012-10-07
category: linux
title: My Gentoo Notes

## Listing installed packages

If you've got the gentoo utility package installed, you can
use```equery``` to search installed packages. It
supports wild cards, e.g.:

    $ equery l *emacs*

## Listing all files belonging to an installed package

This is the equivalent of what we on Debian based systems
would do```dpkg -L &lt;package&gt;``` for:

    $ equery f dev-java/jdbc-mysql

## Configuration files for the init.d scripts

Debian systems use the```/etc/default``` directory structure for
providing configuration for the ```init.d``` scripts. However, in
Gentoo, I've found ```/etc/conf.d``` to provide the same feature.


Hence, to find the configuration for varnish, you'd have to look
in```/etc/conf.d/varnishd``` on Gentoo instead of
```/etc/default/varnish``` as you would on Debian systems. Also note
that Gentoo adds the <cite>d</cite> as in <cite>daemon</cite> to the
file and variables.

