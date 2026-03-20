#!/bin/bash

x=$(tmux capture-pane -p -S '-' -J -t !)
echo "$x" | $EDITOR -
