#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    /usr/bin/xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    /usr/bin/xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    /usr/bin/xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    /usr/bin/xmodmap $usermodmap
fi

xset +fp /usr/share/fonts/terminus/

## Multi monitor setup
xrandr --output DFP11 --auto
#xrandr --output DFP10 --auto --right-of DFP11
xrandr --output DFP10 --auto --left-of DFP11

# run random wallpapers by duration
exec /usr/bin/spectrwm 2&> $HOME/.spectrwm.log
