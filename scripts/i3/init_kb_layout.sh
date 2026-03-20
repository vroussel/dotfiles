#!/bin/sh

setxkbmap us,fr -option "grp:switch" -option "shift:both_capslock"
xmodmap ~/.Xmodmap
