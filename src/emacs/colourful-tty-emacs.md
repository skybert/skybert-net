title: Colourful TTY Emacs
date: 2019-05-27
category: emacs
tags: emacs

<a href="/graphics/emacs/2019/x-emacs-vs-tty-emacs.png">
  <img
    src="/graphics/emacs/2019/x-emacs-vs-tty-emacs.png"
    alt="graphical vs text based emacs"
    style="width: 1024px"
    class="centered"
  />  
</a>

For many years, I've seen avid Emacs users on the interweb say that
they use text based Emacs (aka TTY Emacs) exclusively. I've never
understood this as text based Emacs looks crap compared to a graphical
one. The UI look as flat as VIM and the colour themes look awful.

Last week, though, I took a hard look at what can be done to make TTY
Emacs look better and I found out that some folks use terminals with
24 bit colours.

There's no easy way to get this, though, since apparently there's no
proper "24 bit colour terminal standard". Still, it's fairly easy to
get working though, once you put your mind to it:

## Create a termcap file for 24 bit colours

I created a
[xterm-24bit.terminfo](https://gitlab.com/skybert/my-little-friends/blob/master/x/xterm-24bit.terminfo)
file as is described in the [GNU Emacs
FAQ](https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html)
and installed it in my local termcap registry with:

```
$ tic -x -o ~/.terminfo xterm-24bit.terminfo 
```

## Use a good Terminal 

For years and years, I've used `urxvt`, but it didn't like my new
`termcap` file one bit. My trusty fall back terminal, Konsole, also
had problems making heads or tails of the new setup. I then saw some
folks recommend [kitty](https://sw.kovidgoyal.net/kitty/),  which
turned out to cope with 24 bit colours just fine, as well as 4 byte
UTF-8 characters, which I've been missing out of when using `urxvt`.

What `kitty` installed, I was ready to put those new colours to good
use.

## Set TERM to xterm-24bit

I could now use the above termcap file by setting the `TERM`
environment variable. You can either export it (put `export
TERM=xterm-24bits` in your `.bashrc`) or just put it in front of the
command you want to run with 24 bit colours:

```
$ TERM=xterm-24bits emacs -nw
```

## Enjoy a super colourful TTY Emacs

After starting text based Emacs with the above environment variable,
you can verify that it's working by running `M-x
list-colors-display`. If it lists more than 256 colours, it's
working. I'm getting more than 500 colours bringing it on part with
my graphical Emacs. 

In the picture at the top of this page, you can on the left see my
graphical Emacs running under X using the `Atom One Dark` theme and on
the right TTY Emacs using the same theme. I'm now quite happy to run
text based Emacs whole days at a time, because as [Mark Shuttleworth
wrote](https://www.markshuttleworth.com/archives/63), pretty *is* a
feature 😉


