#!/bin/bash

set -euo pipefail

function get_user_input() {
    prompt=$1
    rofi -dmenu -p "$prompt" -theme-str 'listview {enabled: false;}'
}

label="$(get_user_input "label")"
link=$(xclip -selection clipboard -o 2>/dev/null \
    | sed 's/^\[.*\](\(.*\))/\1/' \
)
with_label="[$label]($link)"
echo -n "$with_label" | xclip -selection clipboard
