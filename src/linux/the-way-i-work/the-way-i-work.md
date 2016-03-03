title: The way I work
category: linux
tags: linux, fluxbox
date: 2015-07-20

<img src="/graphics/2015/my-desktop.png" alt="my desktop" class="centered"/>

<img src="/graphics/2016/debian-logo.jpg"
  style="float: right;"
  alt="fluxbox"
/>
The most important part of my setup is my
[Thinkpad X1 Carbon](http://www.laptopmag.com/reviews/laptops/lenovo-thinkpad-x1-carbon-2015)
laptop with i7 CPU and 8 GB RAM running
[Debian testing](http://debian.org).

To it, I've connected two external screens using the display port and
HDMI ports on the laptop. No splitter or multiplexer was
necessary. The three screens are all a part of the same desktop using
xinemera and xrandr. I've written wee script which will add all
available external screens to the virtual xinerama destkop. This makes
my setup consistent regardless of having 0, 1 or 2 external screens
(or 3 for that
matter). [The 'tkj setup-screens' command can be found here](https://github.com/skybert/my-little-friends/blob/master/bash/tkj)
on github.

<img src="/graphics/2015/fluxbox.jpg"
  style="float: left;"
  alt="fluxbox"
/>

After the laptop itself, my favourite piece of equipment is my
[Happy Hacking Professional 2](https://elitekeyboards.com/products.php?sub=pfu_keyboards,hhkbpro2&pid=pdkb400b)
keyboard.

[Fluxbox](http://fluxborg.org) gives me a lightning fast and is
extremely configurable window manager while yet being pretty to look
at and supports both GNOME and KDE dock apps. I've used it for quite a
while now (since 2002) and have a quite stable
[.fluxbox](https://github.com/skybert/my-little-friends/tree/master/fluxbox)
configuration.

<div style="margin-left: auto; margin-right: auto; width: 30em;">
  <div>
    <span class="grid-box">emacs2</span>
    <span class="grid-box">web2</span>
    <span class="grid-box">talk2</span>
  </div>
  <div style="clear: both;"></div>
  <div>
    <span class="grid-box">emacs</span>
    <span class="grid-box">web</span>
    <span class="grid-box">talk</span>
  </div>
  <div style="clear: both;"></div>
</div>

The number of worskpaces have changed greatly over the years. It's
been stable now since 2011, which hopefully means I've finally arrived
at the "right" number of workspaces ;-) I'm using a 3x2 desktop grid
where the lower 3 desktop row is the main row whereas the row above is
offloading space for the applications on the main row. With three
physical screens, that's in practice 18 virtual screens, which suits
me just fine.

## talk 💬
The `talk` workspace has the different chat clients which I haven't
integrated into my Emacs workflow (yet), like
[Skype](http://skype.com) and [Line](http://line.me).

## web
<img class="right" src="/graphics/2015/firefox.png" alt="firefox"/>
The `web` workspace has my main browser windows and `web2` has
whatever "other" browsers I need to run. Currently, my main browser is
[Firefox](http://firefox.org) and my "other" browsers are
[Google Chrome](http://chrome.google.com), Chromium, Opera &
[Vivaldi](http://vivaldi.com). Of notable plugins for
[Firefox](http://firefox.org), I use
[Firebug](https://addons.mozilla.org/en-us/firefox/addon/firebug/),
[User Agent overrider](https://addons.mozilla.org/en-us/firefox/addon/user-agent-overrider/)
and
[JSONView](https://addons.mozilla.org/en-us/firefox/addon/jsonview/).

## emacs

<img class="right" src="/graphics/emacs/emacs.png" alt="emacs"/>
Lastly, the `emacs` workspace is where I by far spend most of my
time. I use Emacs for most things these days, including email
([mu4e](http://www.djcbsoftware.nl/code/mu/mu4e.html)), chat on
Jabber/GTalk, MSN, Lync/Microsoft Communicator and occationally Skype
([bitlbee](https://www.bitlbee.org) IRC gateway &
[erc](https://www.gnu.org/software/emacs/manual/html_mono/erc.html)),
note taking ([org-mode](http://orgmode.org/)), Java
([eclim](http://eclim.org/) &
[emacs-eclim](https://github.com/senny/emacs-eclim)), Python
([anaconda-mode](https://github.com/proofit404/anaconda-mode)),
presentation slides
([markdown-mode](http://emacswiki.org/emacs/MarkdownMode),
[reveal.js](http://lab.hakim.se/reveal-js/) &
[pandoc](http://pandoc.org)) JavaScript, BASH programming, HTML &
CSS. My complete
[Emacs configuration is available here](https://github.com/skybert/my-little-friends/blob/master/emacs)
on github.

`emacs2` is for other editors or shells that support Emacs,
like running headless Eclipse through the
[eclim plugin](http://eclim.org/). This is also where I start up
[IDEA](http://jetbrains.com/idea) whenever I need to run their
debugger or do some large refactorings in my Java code.

## Text is eyecandy too
On my right most screen, I have [conky](http://conky.sourceforge.net/)
running on the root window, printing useful information of system
resources like CPU, RAM, disk and network, as well as the top running
processes, the time (I auto hid the window manager toolbar where the
clock normally would show), the currently running music and so on. In
many ways, [conky](http://conky.sourceforge.net/) displays the
information that you'd typically have in small dock apps in the
notification area of your desktop toolbar. You can find my
[conky configuration here](https://github.com/skybert/my-little-friends/blob/master/conky/.conkyrc)

## Shell matters 💻

<img class="right" src="/graphics/2015/terminal.png" alt="terminal"/>
When I'm not in Emacs or surfing the web with my web browser, I'm in
the shell. My terminal of choice is
[urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html) which is
lightweight and at the same time has full Unicode support, is
extendable with Perl and supports all features you might be using in
xterm or aterm.

<img class="right" src="/graphics/2015/clipit.svg" alt="clipit"/> To
sync the clipboard with urxvt, I have the following [perl snippet](
https://github.com/skybert/my-little-friends/blob/master/x/.urxvt/perl/clipboard)
for calling
[xsel](http://www.vergenet.net/~conrad/software/xsel/). Together with
these
[settings in .Xresources](https://github.com/skybert/my-little-friends/blob/master/x/x-resources),
I get clickable links in the shell and get two way clipboard syncing
between the other X applications and urxvt. Thanks to
[ClipIt clipboard manager](http://sourceforge.net/projects/gtkclipit/)
I've never had any clipboard problems in any applictation no matter
graphical toolkit: Gtk+, Qt, Swing & AWT applications all work without
a hitch.

## Music ♪ ♫ ♬

<img class="right" src="/graphics/2015/mpd.png" alt="mpd"/>
At work I just have an "endless" playlist of all my music with
keyboard shortcuts to pause/resume and skip. Currently, I'm using
[mpd](http://www.musicpd.org/) which does a fine job of keeping track
of my music. It's fast and runs in the background of everything.

At home, pretty is an important feature and I therefore tend to prefer
[Amarok](https://amarok.kde.org/), even though their old 1.4 version
was better than the new branch of the music player, I think it's the
best and most mature graphical player for the Linux destkop.
