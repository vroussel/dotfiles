#!/bin/bash

tmp_file=$(mktemp)
xfce4-terminal --disable-server -T "__vim_scratch" -e "nvim -c startinsert -c 'setlocal spell' ${tmp_file}" && xclip -selection clipboard < $tmp_file
