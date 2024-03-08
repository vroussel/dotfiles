#!/bin/bash

tmp_file=$(mktemp)
xfce4-terminal --disable-server -T "__vim_scratch" -e "nvim -c startinsert ${tmp_file}" && xclip -selection clipboard < $tmp_file
