title: The way I work in 2025
category: dongxi
date: 2025-03-19
tags: linux, fluxbox, debian, i3

<a href="/graphics/2025/skybert-desk.jpg">
  <img
    class="centered"
    src="/graphics/2025/skybert-desk.jpg"
    alt="My workdesk"
    style="width: 80%; max-width: 900px;"
  />
</a>

One screen. I used to have two screens, then changed to a super wide
screen. These days, I actually find having one, regular external
screen not only sufficient, but also preferable. There's a given
calmnes of having only one screen and it gives me more focus.

The keyboard I'm using at work is [Ducky One 2 Skyline
TKL](https://www.duckychannel.com.tw/en/Ducky-One2-Skyline-TKL). It's
fast and easy to type on. At home, I have my favourite keyboard (and
noisier!), [Happy Hacking Professional
2](https://www.hhkeyboard.com/uk/products/pro2).

Music is a necessity to concentrate. For about five years now, I've
been enjoying the [Sony
WH-1000XM](https://www.sony.com/et/electronics/headband-headphones/wh-1000xm4)
series. The sound is good, the noise cancelling adequate and they're
comfortable to wear.

## Desktop environment

For seven years now, I've been using [i3](https://i3wm.org/). I like
it more and more, how it stays out of the way and lets me get on with
my work. It's highly configurable, and I've had a stable setup for
years.

Apart from [my i3 configuration
itself](https://gitlab.com/skybert/my-little-friends/-/blob/master/i3/config#L1),
the important additions that make i3 great for me are:

[Greenclip clipboard manager](). It supports both text and images and
allows me to have a long history of copied content that I can choose
from when I want to paste it somewhere else. For instance, I often
want to copy 2 things from a Jira issue when pasting it into Slac: The
title and the Jira issue link. So I everything I need, _then_ switch
to the other app, and invoke Greenclip to select what I neeed. I can
do this as many times as I need content from the clipboard.

The second taste of secret sauce for my i3 setup, is
[rofi](https://github.com/davatorium/rofi). It gives me fuzzy search
for switching windows as well as launching applications. It being text
based means it's lightning fast too.

<a href="/graphics/2025/skybert-rofi-window.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-rofi-window.png"
    alt="rofi window"
    style="width: 80%; max-width: 900px;"
  />
</a>

<a href="/graphics/2025/skybert-rofi-window-fuzzy.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-rofi-window-fuzzy.png"
    alt="rofi window fuzzy search"
    style="width: 80%; max-width: 900px;"
  />
</a>

Speed is a big feature of my setup in general. I want it to be
fast. And i3 with rofi and greenclip is indeed fast. It also makes
richer desktop environments not an option for me.

<a href="/graphics/2025/skybert-rofi-run.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-rofi-run.png"
    alt="rofi run"
    style="width: 80%; max-width: 900px;"
  />
</a>

Here showing the rofi dialogue for running a command.

## Coding environment

<a href="/graphics/2025/skybert-emacs-30.1.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-emacs-30.1.png"
    alt="Emacs 30.1 editing some files and using magit"
    style="width: 80%; max-width: 900px;"
  />
</a>

[Emacs](https://www.gnu.org/software/emacs/) is by my preferred code
editing environment and by far the app I used the most. In the
screenshot above, you can see my Emacs 30.1, with [native
compilation](https://www.gnu.org/software/emacs/manual/html_node/elisp/Native-Compilation.html),
and skinned using the [sweet
theme](https://github.com/konkrotte/sweet-theme) and the[Source Code
Pro font](https://github.com/adobe-fonts/source-code-pro) from Adobe.

I've tweaked my
[.emacs](https://gitlab.com/skybert/my-little-friends/-/blob/master/emacs/.emacs?ref_type=heads)
since the year 2000 and have got it about right now, lol.

## Web browser

<a href="/graphics/2025/skybert-firefox.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-firefox.png"
    alt="Firefox using the Sweet dark theme"
    style="float: right; padding: 0.8em; width: 30%; max-width: 300px;"
  />
</a>

My primary browser is Firefox. It's fast, has excellent plugin support
and is the browser being the closest [the four
freedoms](https://www.gnu.org/philosophy/free-sw.en.html), which I
think is an important aspect.

I find it useful to [pin](http://mzl.la/1BARsAT) the websites I use
the most as this will both load the websites I always need when
starting the browser, and I have a fixed screen realestate to go for
these. The sites I have pinned are: [Slack](https://slack.com) for
chat, [Outlook](https://outlook.office.com) for mail,
[Teams](https://teams.microsoft.com) for video chat and calendar,
[Bitbucket](https://bitbucket.org/product/) for PR code reviews and
[ChatGPT](https://chatgpt.com/) for research.

Furthermore, I've changed my way of using the bookmark bar. These
days, I prefer it to be visible at all times, and I've added a button
for creating a screenshot since some websites grab the right click,
which is the normal way [to creates
screenshotts](https://mzl.la/3Qwvmfp).

To make it look nice, I use the beautiful [Sweet-Dark
theme](https://addons.mozilla.org/en-US/firefox/addon/sweet-dark/reviews/)
by Eliver Lara.

The plugin [LanguateTool](https://languagetool.org/) helps improving
my writing of English, German and Norwegian alike.

Websites become a lot easier to read, thanks to [uBlock
Origin](https://github.com/gorhill/uBlock#ublock-origin) blocking
flashy ads.

## Start of the day script

<img
  class="centered"
  src="/graphics/2025/skybert-@home.png""
  style="width: 80%; max-width: 900px;"
  alt="Running my @home script"
/>

I run one of two scripts every morning:
[@home](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40home)
and
[@work](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40work). As
you've probably have guessed, I run `@home` when I work from home and
`@work` when I'm in the office. They set up network access, DNS, VPN,
external screens and other things that are dependent on my physical
location. Both of them then call
[@daily](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40daily),
which ensures my environment is both ready to use and up to date:

1. Starts an SSH agent
1. Syncs my documents and notes
1. Updates the _entire_ operating system
1. Creates a backup of my most important files that are not version controlled.
1. Creates a start page for my browser. The start page has things like my
   recent Git and Jira history the last couple of days, so that I have
   all I need for the standup meeting later in the day.

<a href="/graphics/2025/skybert-dash.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-dash.png"
    alt="Skybert's generated browser start page"
    style="height: 30%; max-height: 400px;"
  />
</a>

The command that creates the start page is called `skybert-dash` and
[you can use it
too](https://github.com/skybert/skybert-dash/blob/main/skybert-dash). The
start page looks like this 👆

## Keeping up with the news

<a href="/graphics/2025/skybert-elfeed.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-elfeed.png"
    alt="Reading RSS feeds in Emacs/elfeed"
    style="width: 80%; max-width: 900px;"
  />
</a>

I get my tech news from two sources: [RSS
feeds](https://en.wikipedia.org/wiki/RSS) and
[Mastadon](https://hachyderm.io/@skybert). Reading RSS feeds with a
good reader, here using [elfeed](https://github.com/skeeto/elfeed) is
super fast and lets me focus on the most important things without
being distractted by animated kittens and other nonsense.

[These are the
feeds](https://gitlab.com/skybert/my-little-friends/-/blob/master/emacs/.emacs.d/tkj-elfeed.el#L6)
I'm currently subscribed to.

## Music

<a href="/graphics/2025/skybert-mpv.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-mpv.png"
    alt="Playing music using the mpv command line client"
    style="width: 80%; max-width: 900px;"
  />
</a>

Although I love Spotify, often times, I prefer playing my local OGG
and MP3 collection using a command line client. I shuffle my entire
collection, ensuring I get a good mix of everything from classical and
opera to hard rock and blues.

```text
$ mpv --shuffle --audio-display=no --input-ipc-server=/tmp/mpvsocket ~/music/
```

I ask [mpv](https://mpv.io/) to set up a socket to which I can control
it using desktop shortcuts. E.g. to pause, I hit <kbd>Ctrl</kbd>
<kbd>Shift</kbd> <kbd>4</kbd>. To jump to the previous track, I hit
<kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>6</kbd> and to jump to next
track, I hit <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>7</kbd>. That's it
really. An eternal play list and three shortcuts. That's all I need.

