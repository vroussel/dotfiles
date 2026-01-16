#!/bin/bash

fzf_menu () {
    title="$1"
    shift
    fzf \
        -i \
        --tmux \
        --border --border-label "$title" \
        --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
        "$@"
}

rofi_menu() {
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

scripts_dir="$1"
menu_type="$2"

case "$menu_type" in
    "fzf")
        menu=fzf_menu
        ;;
    "rofi")
        menu=rofi_menu
        ;;
    *)
        echo "Unknown menu_type (arg 2), use rofi or fzf"
        ;;
esac

pick=$(find "$scripts_dir" -mindepth 1 -executable | xargs -L 1 basename | "$menu" "Script palette") || exit 0
"$scripts_dir/$pick"
