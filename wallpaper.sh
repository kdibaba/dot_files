#!/bin/sh
COUNTER=0
for files in `ls -b ~/grive/wallpapers/gentoo/`
do
COUNTER=$((COUNTER+1))
if [ $COUNTER -eq $1 ]; then
    echo "$files"
    gsettings set org.gnome.desktop.background picture-uri file:///home/qma/grive/wallpapers/gentoo/$files
fi
done
