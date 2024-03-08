#!/bin/sh

sleep 1
setxkbmap us,fr -option "grp:switch" -option "shift:both_capslock"
sleep 1
xmodmap ~/.Xmodmap
