title: My Editor Journey
date: 2024-02-02
category: various
tags: various, emacs

## 1991 - edit

I got my first PC late December 1991. On it was DOS 3 something. I
later got an upgrade to DOS 5 and then 6. The editor on the last two
at least, was [edit](https://en.wikipedia.org/wiki/MS-DOS_Editor).

## 1993-1999 - Notepad

[Notepad](https://en.wikipedia.org/wiki/Windows_Notepad) on Windows
3.1, 3.11, 95, 98, NT 4.

I also used specialised editors for certain tasks, like [Front
Page](https://en.wikipedia.org/wiki/Microsoft_FrontPage), [HoTMetaL
Pro](https://en.wikipedia.org/wiki/HoTMetaL) and
[HomeSite](https://en.wikipedia.org/wiki/Macromedia_HomeSite) for
HTML.

## 1999-2000 - UltraEdit

During my first year, year and a half in univeristy, I came to like
[UltraEdit]() quite a bit. In my first semester, we learned Visual
Basic, so I used that, of course, but used UltraEdit for everything
else.

I used UltraEdit more and more and quickly ditched [JBuilder]() for it
when we started learning Java in the second semester. I quickly
decided I could do without fancy auto completion when I had a better
editing experience.

## 1999 - Visual Studio
The first programming course we had in univeristy was Visual
Basic 6. The IDE was great, with fast auto completion, great, context
aware help system (just hit <kbd>F1</kbd>!) and instant gratification
by running your GUI application when hitting <kbd>F5</kbd>. No matter
how bad your code was, *something* came up when you hit that
<kbd>F5</kbd> key.

Good times.

## 2000 - Pico

In the very beginning of my Unix journey, I used
[pico](https://en.wikipedia.org/wiki/Pico_(text_editor)).

## 2000 → current - Emacs

[Emacs](https://www.gnu.org/software/emacs/). I was intrigued by this
mysterious editor when getting into my second semester as a computer
science student at the [Østfold Univeristy College in
Halden](https://hiof.no). But we were not instant friends, Emacs and
I. It was not very cooperative and only displayed black text on a
white background (in Windows) or yellow-ish on green background on my
RedHat Linux 6.1 dekstop.

But gurus like Thomas Malt and Audun Vaaler were using it, as was the
dean Jan Høiberg, so I supposed it *had* more in store and I shouldn't
judge it by its covers.

So, I spent *ages* getting
[JDE](https://www.emacswiki.org/emacs/JavaDevelopmentEnvironment)
(later renamed JDEE) to work. I had to configure Emacs even to get
colours, and getting true Java auto completion was quite an
undertaking for a newbie. I was stubborn enough, though and eventually
got Emacs to be a decent Java development environment. From that day,
I've never been able to leave Emacs (like the [Hotel
California](https://nn.wikipedia.org/wiki/Hotel_California)).

This is what my Emacs looked like in 2002 on the Window Maker,
complete with a transparent [aterm](https://linux.die.net/man/1/aterm)
on the side.

<a href="/graphics/2002/opengl_on_linux.jpg">
  <img
    class="centered"
    style="width: 1024px"
    src="/graphics/2002/opengl_on_linux.jpg"
    alt="My Emacs anno 2002"
  />
</a>

I'm still using and extending the [.emacs
](https://gitlab.com/skybert/my-little-friends/-/blob/master/emacs/.emacs)
configuration file I started with back in 2000. Some things are
_exactly_ like they were in 2002, like the
`tkj-default-code-style-hook()` function I wrote to get Java and C
indentation the way I wanted.

## 2003 → current - vi(m)

I got my first full time job as a programmer just before
Christmas 2003. It was then, I stared exploring another Unix system,
namely HP-UX. On those servers, there was neither Pico, nor Emacs, but
there was `vi` (there was no `bash` either, for that matter, had to
use `tcsh`). I started using `vi` locally too, and eventually came to
the enhanced `vim` version.

Ever since that day, I've continued to use `vim` and I'm fluent enough
so that I can navigate files, search and replace, line wrap, auto
complete and so on. `vi` has been a trusted tool whatever server I've
worked on, including Solaris, HP-X, FreeBSD, OpenBSD, Linux or OS X.
Learning `vi` is extremely valuable to any computer engineer,
regardless of preferered development environment.

## 2004 → current - IntelliJ IDEA

Although I use Emacs about 99% of the time, I *do* use IntelliJ for
debugging Java code. Its debugger is still *way* ahead of anything
I've tried in Emacs, including `jdb` from JDEE, JDIbug and
dap-mode. Best of which by far was JDIbug, but that's sadly long since
abandoned.
