title: How I failed migrating from X11 to Wayland
date: 2024-06-07
category: linux
tags: linux, i3, wayland

For several years now, people have been saying I should move from
X.org to Wayland. Every time I've tried just a wee bit, I've run into
a problem and switched back. I've also failed to be convinced from the
countless articles and blog posts I've read. X.org works fine for me
and I've stuck with it and XFree86 before that, for more than 20
years.

Until now. Getting a new computer was an opportunity to do something
radically different. Since Wayland has been default on Fedora and
Ubuntu for many years now, I figured it had to be ready for prime
time. Here are my notes as I try to get a working developer
workstation set up.

## Greenclip doesn't work under Wayland 

Start Clipman:
```text
exec wl-paste -w wl-paste -p >> ~/.clipboard-history
```

Then change `~/.config/i3/config`:
```text
bindsym $mod+Control+i exec tac ~/.clipboard-history | rofi -dmenu | wl-copy
```

clipman doesn't support images, though, might want to check out
[clipmon](https://git.sr.ht/~whynothugo/clipmon) later.

## rofi doesn't show all windows under Wayland

Sadly, `rofi -show window` that I've been using before, doesn't show
all windows under Wayland. On my system, it only shows some windows,
like Chrome. It doesn't show apps like Firefox, Emacs, Kitty.

```
$ sway --version
sway version 1.9
$ rofi -v
Version: 1.7.5
```

In `~/.config/i3/config`, I set:
```bash
bindsym Control+Shift+o exec swayr switch-window
exec env RUST_BACKTRACE=1 RUST_LOG=swayr=debug swayrd > /tmp/swayrd.log 2>&1
```

## IntelliJ IDEA doesn't work under Wayland

Starting it just shows a blank screen. It [it was reported
2023-08-16](https://youtrack.jetbrains.com/issue/JBR-3206/Native-Wayland-support)
and they are working on a fix.


```text
$ sway --version
sway version 1.9
```

```ini
$ pacman -Qi intellij-idea-community-edition | head -n 4
Name            : intellij-idea-community-edition
Version         : 4:2024.1.2-1
Description     : IDE for Java, Groovy and other programming languages with advanced refactoring features
Architecture    : x86_64
```

## Signal doesn't load

I tried several times with GNOME3 on Wayland, but could not get Signal
running. Starting it from the command line produced no errors that I
could see, but the window just didn't show.

## Steam doesn't load

Same deal as with Signal. No window. Running it from the command line
showed activity and no errors. The result, though, was no graphical
window displayed on my desktop.

## Summary

I've had it with Wayland/Sway. After a week of trying, I've ditched it
and gone back to X.org/i3.

I've had problems with clip board managers (cannot copy pictures++),
Teams in Firefox (cannot share screen, depends on "operating system
settings", which doesn't resolve to anything on my machine).  IntelliJ
IDEA didn't work on Wayland (still open issue on github), and Signal
regularly froze. As did QEMU running a graphical VM, just gave me a
blank screen.

Good to be back on X.org. Everything works. Command line tools, GUI
tools. Just works.

I will come back and try Wayland/Sway again in a couple of years time
and see where the experience is at then. As for me, [Wayland is not
ready yet, 2024-06-07](https://emacs.ch/@skybert/112575599140521219).
