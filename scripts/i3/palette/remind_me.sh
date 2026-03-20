#!/bin/bash

set -euo pipefail

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export DBUS_SESSION_BUS_ADDRESS

function notify() {
    dunstify -t 1000 "$1"
}

function get_user_input() {
    prompt=$1
    rofi -dmenu -p "$prompt" -theme-str 'listview { enabled: false;}'
}

menu() {
    title="$1"
    shift
    rofi \
        -dmenu \
        -i \
        -p "$title" \
        "$@"
}

trim() {
    awk '{$1=$1};1' || exit 0
}

what=$(get_user_input "remind what ?")
frequency=$(menu 'every' << EOF | trim
    minute
    hour
    day
EOF
)

/usr/bin/todo-txt add "$what freq:$frequency +reminder" && notify "done"
