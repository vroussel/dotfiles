#!/bin/bash

WS_DIR="$HOME/workspace"

repo=$(find "$WS_DIR" -maxdepth 1 -type d -exec test -d '{}/.git' ';' -printf "%f\n" | sort | fzf --border --border-label "Switch project" --tmux --tac) || exit 0
session="$repo"
path="$WS_DIR/$repo"

if ! tmux has-session -t "$session"; then
    tmux new-session -d -c "$path" -s "$session" -n code && tmux send-keys -t "$session:code" 'nvim' C-m
    tmux new-window -d -c "$path" -n term -t "$session:"
fi

tmux switch-client -t "$session"
