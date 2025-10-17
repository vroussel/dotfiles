#!/bin/bash

SCRIPTS_PATH="$HOME/bin/tmux/scripts/"

pick=$(find "$SCRIPTS_PATH" -mindepth 1 | xargs -L 1 basename | fzf --tmux --border --border-label "Script picker") || exit 0
"$SCRIPTS_PATH/$pick"
