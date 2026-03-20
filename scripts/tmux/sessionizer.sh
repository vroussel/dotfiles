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

workspace() {
    WS_DIR="$HOME/ws"
    repo=$(
        cd "$WS_DIR" \
        && find . \
            -maxdepth 3 \
            -type d \
            -name .git \
            -prune \
            -printf "%h\n" \
        | cut -c 3- \
        | sort \
        | menu "Pick workspace"
    ) || exit 0

    path="$WS_DIR/$repo"
    session="$path"

    if ! tmux has-session -t "$session"; then
        temp_dir=$(mktemp -d /tmp/nvim.XXXXX)
        pipe="$temp_dir/pipe"
        tmux new-session -d -s "$session" -n dummy -e "NVIM=$pipe"
        tmux new-window -d -c "$path" -n nvim -t "$session:" \
            && tmux send-keys -t "$session:nvim" "nvim --listen \$NVIM" C-m
        tmux new-window -d -c "$path" -n lazygit -t "$session:" -n \
            && tmux send-keys -t "$session:lazygit" 'lazygit --use-config-file ~/.config/lazygit/config.tmux_project.yml' C-m
        tmux new-window -d -c "$path" -n term -t "$session:"
        tmux kill-window -t "$session:dummy"
        tmux select-window -t "$session:nvim"
    fi

    tmux switch-client -t "$session"
}

conf() {
    CONF_DIR="$HOME/.config"

    declare -A confs=(
        ["nvim"]="$CONF_DIR/nvim"
        ["i3"]="$CONF_DIR/i3/config"
        ["tmux"]="$CONF_DIR/tmux/tmux.conf"
        ["alacritty"]="$CONF_DIR/alacritty/alacritty.toml"
        ["bashrc"]="$HOME/.bashrc"
        ["fish"]="$CONF_DIR/fish/config.fish"
        ["home scripts"]="$HOME/scripts/"
        ["remote bashrc"]="$HOME/.bashrc_remote"
        ["remote vimrc"]="$HOME/.vimrc_remote"
    )

    pick=$(printf "%s\n" "${!confs[@]}" | menu "Pick conf") || exit 0
    target="${confs[$pick]}"
    if [ -d "$target" ]; then
        path="$target"
    else
        path=$(dirname "$target")
    fi
    session="$pick"

    if ! tmux has-session -t "$session"; then
        temp_dir=$(mktemp -d /tmp/nvim.XXXXX)
        pipe="$temp_dir/pipe"
        tmux new-session -d -s "$session" -n dummy -e "NVIM=$pipe"
        tmux new-window -d -c "$path" -n nvim -t "$session:" \
            && tmux send-keys -t "$session:nvim" "nvim --listen \$NVIM $target" C-m
        tmux new-window -d -n lazygit -t "$session:" -n \
            && tmux send-keys -t "$session:lazygit" "lazygit \
                --use-config-file $HOME/.config/lazygit/config.tmux_project.yml \
                --git-dir=$HOME/dotfiles/.git/ \
                --work-tree=$HOME" \
                C-m
        tmux kill-window -t "$session:dummy"
        tmux select-window -t "$session:nvim"
    fi

    tmux switch-client -t "$session"

}

if [ $# -eq 0 ]; then
    type=$(menu 'Choose kind' << "    EOF" | trim
        workspace
        conf
    EOF
    ) || exit 0
else
    type="$1"
fi


case "$type" in
    workspace) workspace ;;
    conf) conf ;;
    *) exit 0 ;;
esac
