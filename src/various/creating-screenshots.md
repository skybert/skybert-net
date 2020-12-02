title: Creating Screenshots
date: 2020-11-26
category: various
tags: firefox, chrome, linux

## Firefox

Firefox has an excellent screenshot tool built in. It lets you select
the whole tab, draw an area to capture. What's more, it understands
the DOM, so it makes it easier to select the DOM component in the web
page. This makes it easier to select e.g. a login dialogue or fact box
accurately.

## Chrome

Currently (2020-11-26) my favourite is [411
screen](https://chrome.google.com/webstore/detail/411screen/pmcklmglhkglcgdfhapidekehecolnfi/related). It
lets you select an area of the web page to screenshot and you can
instantly edit the picture, like highlighting the area of interest
with a rectangle.

I haven't found a way to copy the image to memory, so you'll have to
download it before using it.

## Linux command line

Currently (2020-11-26) my favourite is
[scrot](https://github.com/resurrecting-open-source-projects/scrot), I
typically use it like this:

```text
$ scrot --silent --focused  --count --delay 3  -e 'mv $f /home/torstein/pictures/screenshots' 
```

[Read the *fine* manual](man scrot) for more info
