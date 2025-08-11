title: Move Window by Click Draging It
date: 2025-08-11
category: mac-os-x
tags: mac-os-x, unix, macos, x11

I didn't realise I use this regularly, but now that I'm on macOS, I'm now aware of this tiny, but useful feature of X11.

You can get X11-like move window by clicking anywhere on it by setting
this flag `true`:

```perl
$ defaults write -g NSWindowShouldDragOnGesture -bool true
```

and then logout and in again.

It's `<cmd>` + `<ctrl>` + `<click>` rather than `<alt>` + `<click>`
but close enough.
