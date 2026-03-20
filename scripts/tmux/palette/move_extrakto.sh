#!/bin/bash

pick=$(cat << EOF | fzf --tmux
top left
top right
bottom left
bottom right
top
bottom
left
right
EOF
)

win_width=$(tmux display -p '#{client_width}')
win_height=$(tmux display -p '#{client_height}')

case "$pick" in
    "top left")
        new_pos="0,0"
        new_size="50%"
    ;;
    "top right")
        new_pos="$win_width,0"
        new_size="50%"
    ;;
    "bottom left")
        new_pos="0,$win_height"
        new_size="50%"
    ;;
    "bottom right")
        new_pos="$win_width,$win_height"
        new_size="50%"
    ;;
    "top")
        new_pos="0,0"
        new_size="100%,50%"
    ;;
    "bottom")
        new_pos="0,$win_height"
        new_size="100%,50%"
    ;;
    "left")
        new_pos="0,0"
        new_size="50%,100%"
    ;;
    "right")
        new_pos="$win_width,0"
        new_size="50%,100%"
    ;;
    *)
        new_pos="$win_width,0"
        new_size="50%"
    ;;
esac

tmux set -g @extrakto_popup_position "$new_pos"
tmux set -g @extrakto_popup_size "$new_size"
