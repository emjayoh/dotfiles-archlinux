#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

.screenlayout/screen.sh &

xset r rate 200 30 &

xset -b &

setxkbmap -option terminate:ctrl_alt_bksp &
WALLPAPERFILE=$HOME/Pictures/bg-1.jpg
#if [ -f $WALLPAPERFILE ]; then
    #feh --bg-scale $WALLPAPERFILE &
    #feh --no-startup-id --randomize --bg-seamless ~/.wallpaper/*
#fi

wal -i "$HOME/Pictures/Wallpapers" -a 90

exec i3
