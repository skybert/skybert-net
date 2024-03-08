title: macOS as Unix Workstation 2022
date: 2022-11-21
category: mac-os-x
tags: mac-os-x, unix, emacs, kitty, macOS

<a href="/graphics/2022/macos-unix/unix-ready-macos.png">
  <img
    src="/graphics/2022/macos-unix/unix-ready-macos.png"
    alt="Unix pro environment in macOS"
    style="width: 1024px"
  />
</a>

I'm a die hard Linux user, but in November 2022, I had to use a Mac
for some work.  This document describes how I turned a vanilla install
of the latest macOS into a powerful Unix workstation.

## Homebrew 🍺

This is AFAIK the best package manager for Unix tools on
macOS. Install it with:

```text
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Terminal 💻

I've grown very fond of the [kitty](https://sw.kovidgoyal.net/kitty/)
terminal. I believe it's the best terminal around, it even beats
[iTerm2](https://iterm2.com/) 😃. It strikes a great balance between
features (24 bit colours, Unicode, multiplexer, view pictures on
remote servers, remote server clipboard integration++) and
speed. Install it with:

```text
$ curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

## Set Caps Lock as Ctrl

Or else, I'll go seriously mad.

Head over to `System preferences`, then `Keyboard` and finally
`Modifier Keys`.

## Unix shell environment

### Git
```text
$ brew install git
```

### ZSH 🐚

I prefer the ZSH shell over BASH:

```text
$ brew install zsh
$ brew install zsh-autosuggestions
$ brew install zsh-completions
$ brew install fzf
```

### BASH

You should install a newer version of `bash`. Although I use ZSH for
my interactive shell, I still do lots of shell programming in
BASH. The version of `bash` that comes with macOS is very old,
`3.2.57`, so installing a newer bash with `brew`:

```text
$ brew install bash
```

Verify that the new version is correctly installed and available in
your PATH by running:

```text
$ bash --version
GNU bash, version 5.2.26(1)-release (aarch64-apple-darwin22.6.0)
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

### Coreutils 🧰

GNU `coreutils`, `sed`, `awk`, `getopt` and `grep` are superior to the
ancient BSD tools that ship with macOS.

```text
$ brew install coreutils
$ brew install gawk
$ brew install gsed
$ brew install gnu-getopt
$ brew install grep
```

Now, ensure that the GNU versions of these tools take precedence over
the old BSD versions that macOS ships with. To do this, you must edit
the settings file for your shell.

If you don't know which one you're using, type:
```text
$ echo $SHELL
/bin/zsh
```

With that, you know which `.bashrc` of `.zshrc` to edit. Add the
following:

```conf
export PATH=\
/usr/local/bin:\
/usr/local/Cellar/gnu-sed/4.9/libexec/gnubin:\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/opt/gawk/bin:\
/usr/local/opt/gnu-getopt/bin:\
/usr/local/opt/grep/libexec/gnubin:\
/usr/local/opt/openjdk@11/bin:\
$PATH
```

As you can see from the above paths, `gnused` isn't packaged like the
others, and doesn't provide a `bin` directory outside the cellar.

After this change to your PATH variable, you must reload the settings:
```bash
$ source .bashrc # For BASH shells
$ source .zshrc  # For ZSH shells
```

Alternatively, start a new terminal window.

### PGP 🔒
```text
$ brew install gnupg
```

## Java ☕
```text
$ brew install openjdk@11
```

Ensure this JDK's binaries are first in PATH, add these to `~/.zshrc`
or `~/.bashrc`:

```conf
export PATH=/usr/local/opt/openjdk@11/bin:$PATH
```

## JSON

Installing `jq` allows you to query JSON documents, a bit like what XPath on XML files.
```text
$ brew install jq
```

Installing `json_xs` lets you convert between YAML and JSON. For
instance, you can use this to do look ups in YAML documents using
`jq`. `json_xs` doesn't exist in Homebrew, but you should be able to
install it from CPAN using `cpm` (untested):

```text
$ brew install cpm
$ cpm install JSON::XS
$ cpm install YAML::XS::LibYAML
```


## Video meetings 📽️

My company uses [Microsoft Teams, so that' the one to
get](https://www.microsoft.com/en-us/microsoft-teams/download-app#desktopAppDownloadregion).

Update 2022-11-22: Per told me Teams can also be installed with `brew`
like so:

```text
$ brew install --cask microsoft-teams
```

## Fonts 🖊️

Download the excellent [Adobce Source Code Pro
font](https://github.com/adobe-fonts/source-code-pro/releases/tag/2.038R-ro/1.058R-it/1.018R-VAR),
unzip it and drag and drop the files to the `Font Book`:

<a href="/graphics/2022/macos-unix/macos-font-install.png">
  <img
    src="/graphics/2022/macos-unix/macos-font-install.png"
    alt="install good looking font on macOS"
    style="width: 1024px"
  />
</a>

## A better top

[btop](https://github.com/aristocratos/btop) is my favourite resource
monitor these days, install it with:

```text
$ brew install btop
```

## Emacs 🐂

Install Emacs from [emacsformacosx.com](https://emacsformacosx.com/),
this gives you a good, up to date Emacs build.

Note, this build doesn't provide native compilation (aka "gccemacs"),
nor the non-blocking JSON processing done in this [emacs-lsp
fork](https://github.com/emacs-lsp/emacs).

Update 2022-11-25: It's also possible to get Emacs with `brew`. Note,
after testing this on a fresh Mac, I the `--cask emacs
--with-native-comp --with-cocoa` options didn't work, so had to just
issue the below command which gives a non-graphical Emacs (to get the
full package, use the `emacsformacosx` link above):

```text
$ brew install emacs
```

## Spell check 📖

```text
$ brew install aspell
```

## That's it!

Your shiny macOS machine is now a good, modern Unix workstation with
most of the same tools and versions as GNU/Linux distributions ship
with.

Happy hacking!
