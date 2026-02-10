#!/bin/bash

set -euo pipefail

DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export DBUS_SESSION_BUS_ADDRESS

function notify() {
    notify-send -t 0 "$1"
}

freq="$1"

/usr/bin/todo-txt -p ls +reminder | grep "freq:$freq" | while read -r item; do
    text=$(echo "$item" \
        | sed -E 's/^[0-9]+ (\(\w\) )?//' `#remove itemid + priority` \
        | sed -E 's/ freq:\S*//' \
        | sed -E 's/ \+reminder\S*//' \
    )
    notify "$text"
done
