title: The way I work in 2025
category: dongxi
date: 2025-03-19
tags: linux, fluxbox, debian, i3

## Editing environment

[Emacs](https://www.gnu.org/software/emacs/) is by my preferred code
editing environment and the application I used the most, next to the
web browser and terminal.

<a href="/graphics/2025/skybert-emacs-30.1.png">
  <img
    class="centered"
    src="/graphics/2025/skybert-emacs-30.1.png"
    alt="Emacs 30.1 editing some files and using magit"
    style="width: 1000px"
  />
</a>

In the screenshot about, you can see my Emacs 30.1, with [native
compilation](https://www.gnu.org/software/emacs/manual/html_node/elisp/Native-Compilation.html),
and skinned using the [sweet
theme](https://github.com/konkrotte/sweet-theme) and the[Source Code
Pro font](https://github.com/adobe-fonts/source-code-pro) from Adobe.

I've tweaked my
[.emacs](https://gitlab.com/skybert/my-little-friends/-/blob/master/emacs/.emacs?ref_type=heads)
settings file since the year 2000 and have got it about right now.

## Firefox plugins

I use the beautiful [Sweet-Dark
theme](https://addons.mozilla.org/en-US/firefox/addon/sweet-dark/reviews/?utm_source=firefox-browser&utm_medium=firefox-browser&utm_content=addons-manager-reviews-link)
by Eliver Lara.

[LanguateTool](https://languagetool.org/) helps improving my writing
of English, German and Norwegian alike.

Websites become a lot easier to read, thanks to [uBlock
Origin](https://github.com/gorhill/uBlock#ublock-origin) blocking
flashy ads.

## Start of the day script

<img
  class="centered"
  src="/graphics/2025/skybert-@home.png""
  alt="Running my @home script"
/>

I've three scripts that I run every morning:
[@daily](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40daily),
[@home](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40home)
and
[@work](https://gitlab.com/skybert/my-little-friends/-/blob/master/bash/%40work). I
run `@home` when I work from home and `@work` when I'm in the
office. They set up network access, DNS, VPN, external screens and
other things that are dependent on where I am, and then call `@daily`,
which ensures my environment is both ready to use and up to date:
1. Starts and SSH agent
1. Syncs documents and notes
1. Updates the entire operating system
1. Creates a backup of important files
1. Creates a start page for my browser. The start page has things like my
recent Git and Jira history the last couple of days, so that I have
all I need for the standup meeting later in the day.
