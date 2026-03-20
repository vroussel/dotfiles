#!/bin/bash

set -euo pipefail

menu() {
    title="$1"
    shift
    rofi \
        -dmenu \
        -i \
        -p "$title" \
        "$@"
}

meme_dir="$HOME/scripts/i3/palette/memes"

meme=$(find "$meme_dir" -mindepth 1 | xargs basename | menu "Pick your meme") || exit 0

xclip -selection clipboard -t image/png "$meme_dir/$meme"
notify-send -t 1000 Done
