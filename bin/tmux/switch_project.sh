#!/bin/bash

WS_DIR="$HOME/ws"

repo=$(cd "$WS_DIR" && find . -type d -name .git -prune -printf "%h\n" | cut -c 3- | sort | fzf --border --border-label "Switch project" --tmux --tac) || exit 0
session="$repo"
path="$WS_DIR/$repo"

if ! tmux has-session -t "$session"; then
    tmux new-session -d -c "$path" -s "$session" -n code && tmux send-keys -t "$session:code" 'nvim' C-m
    tmux new-window -d -c "$path" -n term -t "$session:"
fi

tmux switch-client -t "$session"
