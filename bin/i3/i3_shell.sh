#!/bin/bash

window_id=$(xprop -root '_NET_ACTIVE_WINDOW' | awk '{print $NF}')
window_title=$(xprop -id "$window_id" '_NET_WM_NAME')

if echo "$window_title" | grep 'cwd='; then
    name=$(xprop -id "$window_id" '_NET_WM_NAME' | cut -d= -f 2- | tr -d '"')
    _ssh=$(echo "$name" | grep -oP "(?<=ssh=)\S*")
    _cwd=$(echo "$name" | grep -oP "(?<=cwd=)\S*")
    _sudo=$(echo "$name" | grep -oP "(?<=sudo=)\S*")
else
    pid=$(xprop -id "$window_id" '_NET_WM_PID' | awk '{ print $NF }')
    _cwd=$(pwdx "$pid" | awk '{print $NF}' | tr -d '"')
fi

cwd=${_cwd:-$HOME}
if [ -n "$_ssh" ]; then
    alacritty.sh -e bash -c "SSHS_CWD=\"$cwd\" SSHS_SUDO_USER=\"$_sudo\" sshs $_ssh; bash"
else
    alacritty.sh --working-directory "$cwd"
fi
