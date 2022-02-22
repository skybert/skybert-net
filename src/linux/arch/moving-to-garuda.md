title: Moving to Garuda Linux
date: 2022-02-03
category: linux
tags: arch, garuda, linux

After running Garuda on my personal laptop for a couple of weeks, I
decided to move to Garuda on my two work machines too. After ~20 years
of Debian, I now run Garuda on my two laptops and desktop computer.

The whole distribution oozes of quality and attention to detail.

## No flatpaks or snaps

Everythign is in the Arch repositories. I really love this.

From one source, I get all my apps, including:

- Slack
- Signal
- Intellij IDEA
- Spotify
- Google Chrome

As well as the latest and greatest of open source software that I care about:

- Firefox
- Emacs
- kdenlive

I love the fact I can install and upgrade *all* packages using the
operating system's default package manager. 

Flatpaks and snaps work, but it's always a extra pain:

## Pretty

The GRUB boot menu is pretty. The boot progress screen is pretty. The
login screen and the default KDE desktop is ... gorgeous. The fonts,
the colours, the hues, the wallpapers, the icon set. Everything is
consistent and good looking.


## iwd

Getting iwd up and running was a bit tricky. It basically broke both
`sudo` and `systemctl` (!). The reason was that it has some dependency
on systemd's `resolved`, but since it wasn't enabled, it kept
hanging. Massively frustratingly. On the positive side, it let me
explore Garuda's smooth BTRFS snapshot integration from the GRUB
menu. Using that, I selected a snapshot from before I installed `iwd`.

Anyways, to solve this, I did:
```text
$ sudo pacman -Syu iwd
$ systemctl enable --now iwd.service
$ systemctl enable --now systemd-netword.service
$ systemctl enable --now systemd-resolved.service
```

And then, I had to enable on-the-fly configuration of `iwd`. Odd
default if you ask me, on Debian, it "just worked" without any of
this:

```text
# vim /etc/iwd/main.conf
```

```conf
[General]
EnableNetworkConfiguration=true
```

After a restart, `iwd` worked flawlessly:
```text
# systectl restart iwd.service
```
