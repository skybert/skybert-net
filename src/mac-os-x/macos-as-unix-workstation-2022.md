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

This document describes how I turned a vanilla install of macOS into a
powerful Unix environment.

## Emacs 🐂

Install Emacs from [emacsformacosx.com](https://emacsformacosx.com/),
this gives you a good, up to date Emacs build.

Note, this build doesn't provide native compilation (aka "gccemacs"),
nor the non-blocking JSON processing done in this [emacs-lsp
fork](https://github.com/emacs-lsp/emacs).

## Homebrew 🍺

This is AFAIK the best package manager for Unix tools on
macOS. Install it with:

```text
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Spell check 📖

```text
$ brew install aspell
```

## Terminal 💻

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

I prefer the ZSH shell over BASH, but still need an updated BASH for
shell programming. The one that comes with macOS is very old,
`3.2.57`, so installing a newer bash with `brew`:

```text
$ brew install zsh
$ brew install zsh-autosuggestions
$ brew install zsh-completions
$ brew install bash
$ brew install fzf
```

### Coreutils 🧰

GNU `coreutils`, `sed`, `awk`, `getopt` and `grep` are superior to the
ancient BSD tools that ship with macOS:

```text
$ brew install coreutils
$ brew install gawk
$ brew install gsed
$ brew install gnu-getopt
$ brew install grep
```

Add this to your `~/.zshrc` to ensure the GNU coreutils are first in PATH:
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

### PGP 🔒
```text
$ brew install gnupg
```

## Java ☕
```text
$ brew install openjdk@11
```

Ensure this JDK's binaries are first in PATH, add these to `~/.zshrc`:

```text
export PATH=/usr/local/opt/openjdk@11/bin:$PATH
```

## Video meetings 📽️

My company uses [Microsoft Teams, so that' the one to
get](https://www.microsoft.com/en-us/microsoft-teams/download-app#desktopAppDownloadregion).


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

## That's it!

Your shiny macOS machine is now a good, modern Unix workstation with
most of the same tools and versions as GNU/Linux distributions ship
with.

Happy hacking!
