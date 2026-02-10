#!/bin/bash

set -euo pipefail

menu() {
    title="$1"
    rofi \
        -dmenu \
        -i \
        -p "$title" \
        "$@"
}

declare -A gifs
gifs=(
    ["computer trash"]="https://i.giphy.com/kHU8W94VS329y.webp" \
    ["homer bush"]="https://i.giphy.com/COYGe9rZvfiaQ.webp"
    ["no god please no"]="https://giphy.com/gifs/the-office-mrw-d10dMmzqCYqQ0"
    ["AH!"]="https://i.giphy.com/xThtappQfQohgzJMdi.webp"
    ["nouvelle règle"]="https://c.tenor.com/UD7XbjcC5ysAAAAd/tenor.gif"
)

pick=$(printf "%s\n" "${!gifs[@]}" | menu "Pick gif")
link="${gifs[$pick]}"
echo -n "$link" | xclip -selection clipboard
notify-send -t 1000 Done
