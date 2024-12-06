#!/bin/bash
user_input=$(i3-input -F "nop %s" | grep -Po --binary-files=text '(?<=output = ).*' | tr "[:lower:]" "[:upper:]")

if [ $? -ne 0 ]; then
    exit 0
fi

if [ -z "$user_input" ]; then
    i3-msg "title_format %title"
else
    i3-msg "title_format <big><b>[$user_input]</b></big> %title"
fi
