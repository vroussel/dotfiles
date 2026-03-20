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

meme=$(find "$meme_dir" -mindepth 1 | xargs -L 1 basename | menu "Pick your meme") || exit 0

extension="${meme##*.}"
if [ "$extension" == "gif" ]; then
    target="text/plain"
else
    target="image/$extension"
fi

xclip -selection clipboard -t "$target" "$meme_dir/$meme"
notify-send -t 1000 Done
