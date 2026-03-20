#!/bin/bash

tmp_file=$(mktemp)
xclip -o > ${tmp_file}
xfce4-terminal --disable-server -T "__vim_scratch" -e "nvim -c startinsert ${tmp_file}"
xclip -selection clipboard < $tmp_file
