#!/bin/bash

menu () {
    title="$1"
    shift
    rofi \
        -dmenu
        "$@"
}

trim() {
    awk '{$1=$1};1' || exit 0
}

if [ $# -eq 1 ]; then
    source="$1"
else
    source=$(menu 'vim scratch source' << EOF | trim
        clipboard
        selection
        stdin
        blank
EOF
) || exit 0
fi

tmp_file=$(mktemp)

if [ "$source" = "clipboard" ]; then
    xclip -selection clipboard -o > "${tmp_file}"
elif [ "$source" = "selection" ]; then
    xclip -selection primary -o > "${tmp_file}"
elif [ "$source" = "stdin" ]; then
    cat > "${tmp_file}"
fi

alacritty -o ipc_socket=false -T "__vim_scratch" -e nvim -c 'set nofixeol' "${tmp_file}"
xclip -selection clipboard < "$tmp_file"
