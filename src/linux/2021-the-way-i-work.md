title: The way I work in 2021
category: dongxi
tags: linux, fluxbox, debian
date: 2021-03-10

## Lean and mean

I've used Linux as my desktop system for 21 years now, starting my
voyage with GNOME1 and RedHat 6.1, using lots of different distros,
desktop environments, apps and scripts. I hope you enjoy reading how
I've set it up and don't hesitate to send me feedback or suggestions.

### Operating system - Debian GNU/Linux buster/stable

After using RedHat the first two years, I started with [Debian
Potato](https://www.debian.org/releases/potato/) back in 2001 and
apart from a year using Arch, haven't used anything else.

For work, I've used a lot of RHEL, CentOS and Ubuntu (as well as some
Solaris, FreeBSD, SuSE) but I've never been tempted to move away from
Debian on my own machine. It's stable, rock solid and I know my way
around it.

The drawback of Debian stable, is that the software is old. I'm
normally 2 years behind my Arch, Ubuntu and Fedora using
colleagues. To mitigate this, I run LXD system containers with Ubuntu,
CentOS or whatever I need to get an environment with the versions I
need.

But my base, the rock I build on, that stays at [Debian
stable](https://www.debian.org/doc/manuals/debian-faq/choosing.en.html#s3.1).

This approach of using LXD when I need newer software is new. In the
passed, I've used APT pinning and pulled in newer packages from
Debian's `testing` and, occasionally, `unstable` pools. The problem is
that the system quickly becomes more `testing` than `stable`.

A better approach, I find, is to use
[backports](https://backports.debian.org/), but I currently appreciate
having a simple `sources.list` with only the `stable` pool +
security. I have a feeling my system is more stable with only sources
from `stable` (no pun intended), but I haven't re-installed my machine
enough to have evidences of this. It's just a gut feeling.

### Desktop environment - i3

### Login manager - XDM

The more fancy ones like GDM have [security
issues](https://securitylab.github.com/research/Ubuntu-gdm3-accountsservice-LPE)
and have [botched my Bluetooth
setup](https://wiki.archlinux.org/index.php/bluetooth_headset#Gnome_with_GDM)
more than once, besides, I don't really need to switch DE, I'm happy
with i3.

After logging in, my environment is set up with this
[.xsession](https://gitlab.com/skybert/my-little-friends/-/blob/master/x/.xsession)
script.

## Text is king
Sometimes, I use my laptop as my main machine, other times, I `ssh`
into it and use it as a remote workstation. I therefore set up as much
as possible in text mode.

### Colours
Text based Linux shouldn't stand much back from GUI based Linux
IMO. To achieve this, it's paramount that everything supports 24 bit
colours so that we get the same amount of colours GUI apps get to play
with.

#### Create a termcap file for 24 bit colours

Create a
[xterm-24bit.terminfo](https://gitlab.com/skybert/my-little-friends/blob/master/x/xterm-24bit.terminfo)
file as is described in the [GNU Emacs
FAQ](https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html)
and installed it in your local termcap registry with:

```
$ tic -x -o ~/.terminfo xterm-24bit.terminfo 
```

#### Set TERM to xterm-24bit

You can now use the above termcap file by setting the `TERM`
environment variable. You can either export it (put `export
TERM=xterm-24bit` in your `.bashrc`) or just put it in front of the
command you want to run with 24 bit colours:

```
$ TERM=xterm-24bit emacs -nw
```

## Low latency SSH sessions

Compile mosh from source to get 24 bit colour support.

First, install dependencies:
```text
# apt-get install \
    autoconf \
    protobuf-compiler \
    libncurses-dev \
    libssl-dev \
    pkg-config
```

Then compile and install `mosh` from source:
```bash
$ git clone https://github.com/mobile-shell/mosh
$ cd mosh
$ ./autogen.sh
$ ./configure
$ make
$ su -
# make install
```

This gives you `mosh` with 24 bit colours which lets my use the most
colourful editor colour themes, and they're indistinguishable from the
GUI version.

## Open links displayed on remote server in desktop browser
[The Kitty terminal](https://sw.kovidgoyal.net/kitty/) has this
covered out of the box. If a URL is anywhere in the terminal, I can
open it by doing `Ctrl + Shift + e` and selecting which URL by the
number Kitty has inserted.

## Have remote Emacs open links in the desktop browser

When links are rendered in Emacs, for instance when reading email in
[mu4e](https://www.djcbsoftware.nl/code/mu/mu4e.html) or viewing notes
in [org-mode](https://orgmode.org/), the URL is hidden, like on a web
page. When running a GUI Emacs, hitting enter on these links will open
them in the desktop browser. However, when Emacs runs on a remote
machine, a hack is needed.

First off, I set Emacs to write all links to a file instead of opening
them in Firefox:
```lisp
(setq browse-url-generic-program "/home/torstein/bin/firefox"
      browse-url-browser-function 'browse-url-generic)
```

Normally, this `firefox` points to `/usr/bin/firefox` or similar, but
on my server, it's a just a shell script:
```bash
#! /bin/bash
echo "$@" >> $HOME/tmp/links.txt
```

I then use `ssh` to keep a local copy:
```text
$ ssh ssh.example.com tail -f ~/tmp/links.txt > ~/tmp/links.txt
```

The final piece of the puzzle is this call to
[inotify](https://man7.org/linux/man-pages/man7/inotify.7.html) which
listens for changes to `links.txt` and opens the last link written in
Firefox.

```bash
$ while inotifywait -e modify ~/tmp/links.txt; do firefox $(tail -1 ~/tmp/links.txt); done
```

## Display images in the terminal
[kitty](https://sw.kovidgoyal.net/kitty) can [display images in the
terminal](https://sw.kovidgoyal.net/kitty/kittens/icat.html), even
over `ssh`:

Run `ssh` using the kitty `kitten`:
```
$ kitty +kitten ssh remote.example.com
```

Then, on the remote server, install `kitty` (yes, even though it doesn't have X):
```text
# apt install kitty
```

You can now view images by running:
```
$ kitty +kitten icat image.jpg
```

Note that this doesn't work in multiplexers like `screen` and `tmux`.


## Security and privacy

### Disk encryption

I've set up [full disk
encryption](https://cryptsetup-team.pages.debian.net/cryptsetup/encrypted-boot.html)
including the `/boot` partition where the kernels reside.

### Passwords

For several years now, I've had my passwords in the git backed,
[PGP](https://www.ietf.org/rfc/rfc4880.txt) encrypted password manager
aptly named [pass](https://www.passwordstore.org/)

### Chat
My family and most of my friends are all on
[Signal](https://signal.org), I believe they strike a good balance
between convenience, privacy and security.

## Surfing the web

After using Firefox Developer Edition for a long time, I've switched
to [Firefox
ESR](https://support.mozilla.org/en-US/kb/choosing-firefox-update-channel). It
works well for my use and it's wonderful that it comes with the
operating system, I only need to `apt-get install` it from the default
repositories.

### Browser extensions

To be a wee bit more secure and private when surfing the interweb, I
use these browser plugins:

- [Private Badger](https://privacybadger.org/)
- [HTTPS Everywhere](https://www.eff.org/https-everywhere)

I also grown fond of these plugins:

- [LanguageTool](https://languagetool.org/)
- [Disable Javascript](https://github.com/dpacassi/disable-javascript)

## The look

<img
  src="https://draculatheme.com//static/icons/pack-1/045-dracula.svg" 
  alt="Dracula" 
  width="220" 
  height="220"
  style="float: right"
/>

These days, I prefer the [Dracula theme](https://draculatheme.com/)
and have managed to hunt down or create configuration for most of the
apps I use every day to use these colours.

- In Mozilla Firefox, I use the [Dracula Dark Theme](https://addons.mozilla.org/en-GB/firefox/addon/dracula-dark-colorscheme/)
- In Google Chrome, I use the [Dracula Chrome Theme - Dark and Minimal](https://chrome.google.com/webstore/detail/dracula-chrome-theme-dark/gfapcejdoghpoidkfodoiiffaaibpaem)
- In Emacs, I use the [dracula-theme](https://github.com/dracula/emacs), installed from MELPA.
