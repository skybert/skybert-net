title: The way I work in 2015
category: dongxi
tags: linux, fluxbox, debian
date: 2015-07-20

<img src="/graphics/2015/my-desktop.png" alt="my desktop" class="centered"/>

I always enjoy reading about other people's setup. I can always pick
up a tip or two, or at the very least get an idea on how to apply some
of the same principles to my own setup. Just because I'm not a Mac OSX or
a vim user, doesn't mean I cannot learn from an article with that kind
of workflow! This article is may way of giving something back, I hope
you will enjoy my tale.

<div style="text-align: center;">
 <a href="#hardware">Hardware</a>
 <a href="#os">Operating system</a>
 <a href="#de">Desktop environment</a>
 <a href="#emacs">Editors</a>
 <a href="#talk">Chat & talk</a>
 <a href="#web">Web Browsers</a>
 <a href="#shell">Shell</a>
 <a href="#music">Music</a>
</div>

## <a name="hardware"></a> The hardware
My work horse is
a
[Thinkpad X1 Carbon](http://www.laptopmag.com/reviews/laptops/lenovo-thinkpad-x1-carbon-2015) laptop
with i7 CPU and 8 GB RAM. To it, I've connected two external screens
using the display port and the HDMI port on the laptop. No splitter or
multiplexer was necessary. The three screens are all a part of the
same desktop using xinemera and xrandr. I've written wee script which
will add all available external screens to the virtual xinerama
destkop. This makes my setup consistent regardless of having 0, 1 or 2
external screens (or 3 for that
matter). The
[tkj setup-screens](https://github.com/skybert/my-little-friends/blob/master/bash/tkj) command
can be found on github on my github page.

After the laptop itself, my favourite piece of equipment is
my
[Happy Hacking Professional 2](https://elitekeyboards.com/products.php?sub=pfu_keyboards,hhkbpro2&pid=pdkb400b) keyboard. It's
really fun to type on. It sounds weird, but sometimes when walking to
work in the morning I can look forward to getting into the office and
type on it again. It's that great. It's something about the feel of
the keys and the flow it gives you. Of course, it's NOISY so you
better get noise cancelling headphones for all your colleagues. Or buy
them cake, that works too 😉

## <a name="os"></a> The operating system

<img src="/graphics/2016/debian-logo.png"
  style="float: right;"
  alt="debian"
/>

I run [Debian GNU/Linux](http://debian.org) (testing). Debian has been
my workstation OS since 2001, and except a one year flirt
with [Arch](http://archlinux.org), I've been faithful ever since. I
find it a nice blend of a lean distro (I start off with just a bare
boned install, without X, without `zip`++ and build it from there,
installing just the packages I need) and one which is easy to get
working with new hardware and commercial applications
like [Steam](http://store.steampowered.com/)
and [Skype](http://skype.com).

Compared to e.g. Ubuntu, there *is* more work getting Debian to work,
but it's a rewarding effort and it's getting easier with every
release.

## <a name="de"></a> The desktop environment

<img src="/graphics/2015/fluxbox.jpg"
  style="float: right;"
  alt="fluxbox"
/>

[Fluxbox](http://fluxborg.org) gives me a lightning fast and is
extremely configurable window manager while yet being pretty to look
at. It supports both GNOME and KDE dock apps and have a good selection
of themes. I've used it for quite a while now (since 2002) and have a
quite
stable
[~/.fluxbox](https://github.com/skybert/my-little-friends/tree/master/fluxbox) configuration. Getting
up and running on a new computer takes just a minute or two. A few
symlinks to my github configuration is all that it takes.

<div style="margin-right: auto; width: 30em;">
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
at the "right" number of workspaces 😉 I'm using a 3x2 desktop grid
where the lower 3 desktop row is the main row whereas the row above is
offloading space for the applications on the main row. With three
physical screens, that's in practice 18 virtual screens, which suits
me just fine.

### Going the extra mile to rid myself of the mouse
I primarily use the mouse for image editing and web browsing. Thus, I
have a number of shortcuts configured in Fluxbox, including:
maximise/minimise window, turn on/off window decorations (to get more
screen real estate), navigate between workspaces, move & resize
windows. I prefix all my DE shortcuts with <kbd>Ctrl</kbd> +
<kbd>Shift</kbd> and have chosen the vim letters for left, right, up,
down to form the move shortcuts. 

I try to re-map shortcuts in various applications so that they serve
similar functions. The VIM shortcuts for moving around the windows is
one example, <kbd>Ctrl</kbd> + <kbd>,</kbd> is another. In Emacs it
gives me a list of all functions in the current file (`imenu`) and in
Vivaldi it gives me a list of all the tabs in the current browser
window.

#### Changing between keyboard layouts 🎏
Having shortcuts for switching directly to a given keyboard layout
(not cycle between them) is a must. American layout is the best for
programming, but I also need Norwegian and German for writing emails.

Some DEs like OSX insists on having the user to cycle through the
available layouts (press the shortcut once to go the next one, again
to the one after that and so on). I find this unsatisfactory since it
requires me to either look at the language switcher (and thus take my
eyes off what I'm writing) or I have to test-type a few character to
see if I'm on the layout I want.

Lastly, cycling layouts is bad because it leaves no way to guarantee
that you are on a given layout. With dedicated shortcuts for layouts,
I can be certain that I'm using American before typing a password
containing special characters where using German layout would make me
enter the password wrongly.

#### Only one application has a desktop shortcut
I used to have shortcuts for launching my favourite apps, but these
days I only have one: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> +
<kbd>t</kbd> (new terminal). The reason for this is that most of my
favourites are opened once during login (from `.xinitrc`) and they
just keep running forever (forever being a month or two before a
kernel upgrade forces me to reboot the machine). The exceptions from
this can easily be started from a terminal — and I don't start them
often enough to warrant for a dedicated shortcut.


#### Fast tracking common web browser operations
Since I'm always either in a terminal or have one next to my current
window, I've made a few simple BASH scripts for doing common online
things. For instance, my company uses JIRA for ticketing, so I've got
this wee command `j`, which will open my browser with the JIRA issue
key I give it (`j FOO-1234`).

Similarly, I've got the command `g` which will open my browser with a
Google search performed on the string I pass it (`g What is the answer
to life the universe and everything`).

### Navigating to any app on any workspace

[Fluxbox](http://fluxbox.org) (from version 1.3.7) has fuzzy search
for any application open on any of my six workspaces. I hit
<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>o</kbd> to get the dialogue
and type any part of the application's window title to navigate to it.

<img src="/graphics/2016/2016-12-08-fluxbox-fuzzy-search-black-bg.png"
  alt="fluxbox app navigation"
  class="centered"
/>

In this example, I've typed "fire" to navigate to
my [Firefox](http://mozilla.org/firefox) whose window title is: "JSON
Schema - Mozilla Firefox". This is really fast and makes it easy to
have applications scattered around on the different workspaces while
keeping them within easy to reach.

## <a name="talk"></a> talk 💬
I'd like to keep all communication related distractions on the `talk`
workspace, leaving me "in flow" when I'm coding on my `emacs`
workspace or surfing the web on my `web` workspace.

The `talk` workspace has an Emacs session for reading my email
and [Slack](http://slack.com) chats
(using [emacs-slack](https://github.com/yuya373/emacs-slack)), as well
as the different chat clients which I haven't integrated into my Emacs
workflow (yet), like [Skype](http://skype.com)
and [Line](http://line.me).

## <a name="web"></a> web
<img class="right" src="/graphics/2015/firefox.png" alt="firefox"/>
The `web` workspace has my main browser windows and `web2` has
whatever "other" browsers I need to run. Currently, my main browser is
[Vivaldi](http://vivaldi.com) and my "other" browsers are
[Google Chrome](http://chrome.google.com), Chromium, Opera &
[Firefox](http://firefox.org). Of notable plugins for
[Firefox](http://firefox.org), I use
[Firebug](https://addons.mozilla.org/en-us/firefox/addon/firebug/),
[User Agent overrider](https://addons.mozilla.org/en-us/firefox/addon/user-agent-overrider/)
and
[JSONView](https://addons.mozilla.org/en-us/firefox/addon/jsonview/).

I always crave for keyboard based navigation and Vivalid has a really
nice dialogue which I've bound to <kbd>Ctrl</kbd> + <kbd>,</kbd>. It
allows me to jump to any tab by fuzzy searching:

<img
  class="centered"
  src="/graphics/2016/vivaldi-fuzzy-search.png"
  style="width: 600px;"
  alt="fuzzy search in Vivaldi"
/>  


## <a name="emacs"></a> emacs

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

## <a name="text"></a> Text is eyecandy too
On my right most screen, I have [conky](http://conky.sourceforge.net/)
running on the root window, printing useful information of system
resources like CPU, RAM, disk and network, as well as the top running
processes, the time (I auto hid the window manager toolbar where the
clock normally would show), the currently running music and so on. In
many ways, [conky](http://conky.sourceforge.net/) displays the
information that you'd typically have in small dock apps in the
notification area of your desktop toolbar. You can find my
[conky configuration here](https://github.com/skybert/my-little-friends/blob/master/conky/.conkyrc)

## <a name="shell"></a> Shell matters 💻

<img class="right" src="/graphics/2015/terminal.png" alt="terminal"/>
When I'm not in Emacs or surfing the web with my web browser, I'm in
the shell. My terminal of choice is
[urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html) which is
lightweight and at the same time has good Unicode support (up to 3
byte UTF-8 only, not 4 byte characters), is extendable with Perl and
supports all features you might be using in xterm or aterm.

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

## <a name="music"></a> Music ♪ ♫ ♬

<img class="right" src="/graphics/2015/mpd.png" alt="mpd"/>
At work I just have an "endless" playlist of all my music with
keyboard shortcuts to pause/resume and skip. Currently, I'm using
[mpd](http://www.musicpd.org/) which does a fine job of keeping track
of my music. It's fast and runs in the background of everything.

At home, pretty is an important feature and I therefore tend to prefer
[Amarok](https://amarok.kde.org/), even though their old 1.4 version
was better than the new branch of the music player, I think it's the
best and most mature graphical player for the Linux destkop.

## That's it

Thank you for reading this far, I hope you've found a few bits and
pieces that are useful to you or you've simply gotten an idea on how
to implement a feature in a different way for your desktop and
workflow.

Any comments or suggestions are most welcome. Or indeed tell me how
*your* setup is. I'd be happy to read about it.

Happy hacking.
