#!/bin/bash

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
    exit 1
fi

tmp_file=$(mktemp)

if [ "$1" = "clipboard" ]; then
    xclip -selection clipboard -o > ${tmp_file}
elif [ "$1" = "primary" ]; then
    xclip -selection primary -o > ${tmp_file}
elif [ "$1" = "stdin" ]; then
    cat > ${tmp_file}
elif [ "$1" = "arg" ]; then
    echo -n "$2" > ${tmp_file}
fi

alacritty -o ipc_socket=false -T "__vim_scratch" -e nvim -c 'set nofixeol' ${tmp_file}
xclip -selection clipboard < $tmp_file
