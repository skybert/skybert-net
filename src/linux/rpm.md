date:    2012-10-07
category: linux
title: My RPM Notes
tags: redhat

## Listing installed packages
    $ rpm -qa

## Listing all files of an installed package
    $ rpm -ql &lt;package&gt;

## Viewing package information
    $ rpm -qi &lt;package name without version and arch&gt;

Or you can ask YUM:

    $ yum info &lt;package&gt;

## Installing a package
    # rpm -Uvh package-name-arch-version.rpm

