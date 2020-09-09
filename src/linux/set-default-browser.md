title: Set default web browser on Linux
date: 2020-09-09
category: linux
tags: linux

On Debian based systems, the default browser is set using the
[alternatives
mechanism](https://manpages.debian.org/stretch/dpkg/update-alternatives.1.en.html).


## Get browser categories
```text
# update-alternatives --get-selections | grep browser
gnome-www-browser              auto     /usr/bin/google-chrome-stable
x-www-browser                  auto     /usr/bin/google-chrome-stable
```

## Get registered alternatives
```text
# update-alternatives --list gnome-www-browser
/usr/bin/firefox-esr
/usr/bin/google-chrome-stable
# update-alternatives --list x-www-browser
/usr/bin/firefox-esr
/usr/bin/google-chrome-stable
/usr/bin/konqueror
```


## Set your preferred web browser
```text
# update-alternatives --set x-www-browser /usr/bin/firefox-esr 
update-alternatives: using /usr/bin/firefox-esr to provide /usr/bin/x-www-browser (x-www-browser) in manual mode
# update-alternatives --set gnome-www-browser /usr/bin/firefox-esr 
update-alternatives: using /usr/bin/firefox-esr to provide /usr/bin/gnome-www-browser (gnome-www-browser) in manual mode
```

## Success

All apps should now use your default web browser, as long as you
haven't set the browser to use explicitly in the app's settings.

Happy browsing!
