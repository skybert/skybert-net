#! /bin/bash
##################################################
# Torstein's .xinitrc file
##################################################

##################################################
# Loading the settings from .bashrc so that
# prorams started from other places than the
# shell, also get these settings (LC_ALL, CLASSPATH
# etc).
##################################################
. $HOME/.bashrc

##################################################
# Turning the system bell off.
##################################################
xset -b

##################################################
# Starting window manager.
##################################################
fluxbox & wmpid=$!

##################################################
# set up xinerama
##################################################
xrandr  --output VGA1 --off
xrandr  --output VGA1 --right-of LVDS --pos 1440x900 --auto

##################################################
# Programs to be automatically started at login. 
##################################################

# getting GNOME settings and plug and play.  
gnome-settings-daemon &
gnome-volume-manager &

# GNOME now has its own clipboard, so we need to start
# the xclipboard first, othwerwise it doesn't start.
# xclipboard &
# using glipper instead of xclipboard
/usr/lib/glipper/glipper -w &

# hide the mouse pointer if idle for two seconds
unclutter -idle 2 &

# swap the useless caps lock key with an additional control key
setxkbmap -option ctrl:nocaps

# keymapping file
xmodmap .xmodmap

# network applet
nm-applet &

# starting the (correct) screensaver
killall -9 gnome-screensaver
xscreensaver &

# wallpaper
display -window root -backdrop ~/graphics/wallpaper &

# root window
# ensuring that the root tails get no problems with locale.
# LC_ALL=C
# root-tail\
#    -g 1350x200+20+650\
#    --color darkgray\
#    -font 6x12\
#    /var/log/messages &
# root-tail\
#    -g 1350x200+20+450\
#    --color darkgray\
#    -font 6x12\
#    /var/log/daemon.log &
    
# conky &

##################################################
# Keep window manager running till I quit :-)
##################################################
wait $wmpid

##################################################
# Things to do when logging out.
##################################################

