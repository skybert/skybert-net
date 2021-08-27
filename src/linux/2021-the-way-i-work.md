title: The way I work in 2021
category: dongxi
tags: linux, fluxbox, debian
date: 2021-03-10

<a href="/graphics/2021/2021-07-27-emacs-and-tmux.png">
  <img
    src="/graphics/2021/2021-07-27-emacs-and-tmux.png"
    alt="emacs in tmux"
    class="centered"
    style="width: 1024px;"
  />
</a>

I've used Linux as my desktop system for 21 years now, starting my
Linux voyage with GNOME 1 and [RedHat 6.1
Cartman](https://en.wikipedia.org/wiki/Red_Hat_Linux#Version_history),
using lots of different distros through the years (RedHat, SuSE,
Mandrake, Debian, Ubuntu, Stormix, Progeny, Sidux, Ubuntu), desktop
environments (WindowMaker, Fluxbox, KDE, GNOME 1-3), apps and
scripts. This article describes where I'm currently at in my Linux
story. Hope you enjoy reading how I've set everything it up and don't
hesitate to send me feedback or suggestions.

## Lean and mean
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
<img
  src="/graphics/2021/kitty-icat.png"
  alt="viewing images in the terminal over SSH"
  class="centered"
/>

[kitty](https://sw.kovidgoyal.net/kitty) can [display images in the
terminal](https://sw.kovidgoyal.net/kitty/kittens/icat.html), even
over `ssh`:

Run `ssh` using the kitty ssh kitten:
```
$ kitty +kitten ssh remote.example.com
```

Then, on the remote server, install `kitty` (yes, even though it
doesn't have X):

```text
# apt-get install kitty
```

You can now view images by running:
```
$ kitty +kitten icat image.jpg
```

I find it useful to have the last command as an alias in my `.zshrc`
(same works in `.bashrc` if you're using `bash`):

```bash
alias icat='kitty +kitten icat'
```

Note that this [doesn't
work](https://github.com/kovidgoyal/kitty/issues/413) in multiplexers
like `screen` and `tmux`.

## Clipboard

I use [greenclip](https://github.com/erebe/greenclip) as my clip board
manager. This allows me to select as many copied items as I want to,
not just the previous selection or text I hit <kbd>Ctrl</kbd> +
<kbd>c</kbd>. After using a clipboard manager for many years, I can
never go back to just having the default one, being able to only copy
one text at a time.

Say I want to pay a bill in my online bank and I have the invoice as a
PDF. With `greenclip`, I can copy the amount, the KID number and the
recipient's account number and *em* then swithc to my bank's web site
and paste them in one after another, without switching back and forth
between the bank site and the invoice PDF.

As front end for `greenclip`, I use [rofi via a i3
shortcut](https://gitlab.com/skybert/my-little-friends/-/blob/master/i3/config#L41). That
even gives me fuzzy search, so if there's a password I paste often,
and I remember parts of it, like I know there's a double `7` in it, I
hit <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>i</kbd> to lauch rofi,
then type `77` and it's on my clipboard. I then switch to the
application where I need it and hit <kbd>Shift</kbd> +
<kbd>Insert</kbd> to paste it in.

## Copy text to clipboard over SSH

Most of the time, I prefer using [kitty's clipboard
kitten](https://sw.kovidgoyal.net/kitty/kittens/clipboard.html), which
allows me to copy text to the local clipboard with:

```text
$ echo hello world | kitty +kitten clipboard
$ cat /etc/hosts | kitty +kitten clipboard
```

If I only need a line or two, I select the text with the mouse and it
goes straight to the local clipboard thanks to these settings in my
`~/.conf/kitty/kitty.conf`:

```text
copy_on_select         yes
strip_trailing_spaces  always
```

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

These days, I prefer the [Sweet
theme](https://github.com/EliverLara/Sweet) and have managed to hunt
down or create configuration for most of the apps I use every day to
use these colours.

- In Mozilla Firefox, I use the [Minimal Dark Sweet](https://addons.mozilla.org/en-US/firefox/addon/minimal-dark-sweet/)
- In Google Chrome, I use the [Dracula Chrome Theme - Dark and Minimal](https://chrome.google.com/webstore/detail/dracula-chrome-theme-dark/gfapcejdoghpoidkfodoiiffaaibpaem)
- In Emacs, I use the [sweet-theme](https://github.com/2bruh4me/sweet-theme), installed from MELPA.
- In Kitty, I've written [my own sweet theme](https://gitlab.com/skybert/my-little-friends/-/blob/master/kitty/sweet-kitty.conf)
- In i3, I've written [my own sweet theme colour config](https://gitlab.com/skybert/my-little-friends/-/blob/master/i3/config#L180)
- In rofi, I've written [my own sweet rasi file](https://gitlab.com/skybert/my-little-friends/-/blob/master/rofi/sweet.rasi)
