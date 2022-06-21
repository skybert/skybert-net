title: What is Baloo and why is it Eating My Machine?!
date: 2022-06-21
category: linux
tags: linux, kde

Baloo was number one in `top` and I didn't even know what it was. Turned out it was the search indexer for the KDE Plasma dekstop. The funny thing was,  I didn't even run KDE at the time, I was running `i3`! But since Baloo is started from `systemd`, it was eating away my CPU sycles anyway.

This is how I got rid of this resource hog:

## Stopping the baloo indexer

```text
$ balooctl suspend
```


## Disable the baloo indexer

```text
$ balooctl disable
Disabling and stopping the File Indexer
```

You can verify that it's been disabled:

```text
$ cat .config/baloofilerc
[Basic Settings]
Indexing-Enabled=false
```

## Purge the giga bytes consumed byt he indexer

Since I never use KDE for anything useful on this machine, it's my
work machine, so I use `i3`, I decided to purge the whole file to save
the disk space (it was occupying more than 4 GBs):

```text
$ balooctl purge
```

