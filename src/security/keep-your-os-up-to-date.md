title: Keep your OS secure and up to date
date: 2023-01-18
category: security
tags: security, windows, osx, linux, unix

The best and easiest way of keeping your machine secure, is to
constantly upgrade all of its components. Not only a few selected
apps like Chrome, but all components, including the git command, the
SSL/TLS libraries and so on. Below, I list the commands I use on the
different platforms I frequent (plus Windows).

## Debian & Ubuntu based machines

```text
# apt-get update && apt-get upgrade
```

## Arch based machines
```text
# pacman -Syu
$ paru -Syu
```

## RedHat 8 and Fedora based machines
```text
# dnf upgrade
```

## RedHat 7 based machines

```text
# yum upgrade
```

## OpenBSD 
```text
# syspatch
```

## macOS 
```text
# softwareupdate -i -a
$ brew upgrade
```

## Windows 10 1709 (build 16299) or later 

```text
c:\> winget upgrade --all
```

## Legend

As always, `#` means the command should be executed as `root` or with
`sudo` and `$` means the command should be executed by your regular
user.
