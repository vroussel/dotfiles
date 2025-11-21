#!/bin/bash

menu () {
    title="$1"
    shift
    fzf \
        -i \
        --tmux \
        --border --border-label "$title" \
        --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down \
        "$@"
}

trim() {
    awk '{$1=$1};1' || exit 0
}

SCRIPTS_PATH="$HOME/scripts/tmux/scripts/"

pick=$(find "$SCRIPTS_PATH" -mindepth 1 | xargs -L 1 basename | menu "Script palette") || exit 0
"$SCRIPTS_PATH/$pick"
