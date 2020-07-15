title: Add Generic X session to SDDM menu
date: 2020-07-15
category: linux
tags: linux, kde

I like to define how my X session starts, what locale it runs under,
which apps are started by default and so on. For many years, I've
maintained the same `.xsession` file, only changing a line here and
there as I move through clipboard managers, favourite browser or
indeed, favourite Window Manager.

Lately, I've switch to SDDM and saw to my surprise that there was no
"Custom X session" option to let me use my `.xsession` instead of
whatever sessions installed on the system (KDE Plasma, i3, GNOME and
so on).

As often is the case on Linux, creating a text file in the right place
on the machine with the right content, saved the day:

First, create a new file in `/usr/share/xsession`:

```
# vim /usr/share/xsessions/xsession.desktop
```

with this content:

```conf
[Desktop Entry]
Name=X session
Comment=X session, controlled by your ~/.xsession
Exec=/etc/X11/Xsession
TryExec=/etc/X11/Xsession
Type=Application
X-LightDM-DesktopName=X session
DesktopNames=X session
```

Log out and back in again. SDDM should now have a new Desktop session
to choose from called "X session". Congratulations, you can now
control the X session from the comfort of your `~/.xsession` 😃
