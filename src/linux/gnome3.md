title: GNOME3
date:    2012-10-07
category: linux
tags: gnome

## Changing the window decoration theme in GNOME3

I googled around a bit for this one and didn't find any answer
which worked for me (using gconf edit or gconf2 didn't cut it
for me and re installing Debian packages to get back desktop
settings isn't my idea of being in control), hence I did some
command line walking and found the GNOME3 window decoration
theme set there:

    $HOME/.gconf/desktop/gnome/shell/windows/%gconf.xml


To pick a theme to set here, have a look at the ones you've
got installed in```/usr/share/themes```.  Then, set it
like this:

    <?xml version="1.0"?>
    <gconf>
      <entry name="theme" mtime="1322056983" type="string">
        <stringvalue>Adwaita</stringvalue>
      </entry>
    </gconf>


Where <strong>Adwaita</strong> is the theme I chose from the
ones found in```/usr/share/themes```

## Getting integrated Pidgin support in GNOME3

I used this GNOME3 Shell extension which so far seems to work,
although it doesn't allow me to respond to the message popups, like
Empathy can in GNOME3.

    $ cd /usr/local/src/
    $ git clone git://github.com/kagesenshi/gnome-shell-extensions-pidgin.git
    $ cd $HOME/.local/share/gnome-shell/extensions/
    $ mkdir "pidgin@gnome-shell-extensions.gnome.org"
    $ cd "pidgin@gnome-shell-extensions.gnome.org"
    $ ln -s /usr/local/src/gnome-shell-extensions-pidgin/extension.js
    $ ln -s /usr/local/src/gnome-shell-extensions-pidgin/metadata.json

You must then reload```gnome-shell```.
