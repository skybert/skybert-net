date:    2012-10-07
category: linux
title: My RPM Notes
tags: redhat

## Listing installed packages
    $ rpm -qa

## Listing all files of an installed package
    $ rpm -ql <package>

## Viewing package information
    $ rpm -qi <package name without version and arch>

Or you can ask YUM:

    $ yum info <package>

## Installing a package
    # rpm -Uvh package-name-arch-version.rpm


## Which package provides a file

```
$ rpm -qf <file>
```

You can also query `yum`:
```
$ yum whatprovides <file>
```
