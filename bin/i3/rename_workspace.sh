#!/bin/bash
WS=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
user_input=$(i3-input -F "nop %s" | grep -Po --binary-files=text '(?<=output = ).*')

if [ $? -ne 0 ]; then
    exit 0
fi

if [ -z "$user_input" ]; then
    i3-msg "rename workspace to \"$WS\""
else
    i3-msg "rename workspace to \"$WS: <b>${user_input}</b>\""
fi
