#!/bin/bash

WS_DIR="$HOME/ws"

repo=$(cd "$WS_DIR" && find . -maxdepth 3 -type d -name .git -prune -printf "%h\n" | cut -c 3- | sort | fzf --border --border-label "Switch project" --tmux --tac) || exit 0
session="$repo"
path="$WS_DIR/$repo"

if ! tmux has-session -t "$session"; then
    temp_dir=$(mktemp -d /tmp/nvim.XXXXX)
    pipe="$temp_dir/pipe"
    tmux new-session -d -c "$path" -s "$session" -n nvim -e "NVIM=$pipe" \
        && tmux send-keys -t "$session:nvim" "nvim --listen \$NVIM" C-m
    tmux new-window -d -c "$path" -n term -t "$session:" -n lazygit \
        && tmux send-keys -t "$session:lazygit" 'lazygit --use-config-file ~/.config/lazygit/config.tmux_project.yml' C-m
    tmux new-window -d -c "$path" -n term -t "$session:"
fi

tmux switch-client -t "$session"
