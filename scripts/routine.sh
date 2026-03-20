#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

action="$1"

function file_size {
    stat --printf="%s" "$1"
}

function status_refresh {
    pkill -SIGRTMIN+4 i3-status-rs
}

function start {
    mkdir -p /tmp/routine
    cp "$HOME/scripts/routine.csv" /tmp/routine/tasks
    next
}

function next {
    name=""
    while [ -z "$name" ] || [[ "$name" = \#* ]]; do
        if [ "$(file_size /tmp/routine/tasks)" -eq 0 ]; then
            cleanup
            exit 0
        fi
        IFS=, read -r name cmd timer < /tmp/routine/tasks
        sed -i '1d' /tmp/routine/tasks
    done

    echo "$name" > /tmp/routine/current_name
    if [ -n "$timer" ]; then
        date -d "+$timer seconds" +%s >/tmp/routine/current_deadline
    else
        rm -f /tmp/routine/current_deadline
    fi
    $cmd
    status_refresh
}

function cleanup {
    rm -r /tmp/routine
    status_refresh
}

function print_current {
    text=""
    state="Info"

    if [ -f /tmp/routine/current_name ]; then
        name=$(cat /tmp/routine/current_name)
        text="  $name"
    fi

    if [ -f /tmp/routine/current_deadline ]; then
        deadline=$(cat /tmp/routine/current_deadline)
        now=$(date '+%s')
        time_left=$(( deadline - now))
        if [ "$time_left" -le 0 ]; then
            state="Warning"
        fi
        time_left_pretty=$(printf "%02dm %02ds" "$((time_left/60))" "$((time_left%60))")
        text="$text ($time_left_pretty left)"
    fi

    cat << EOF
{
  "state": "$state",
  "text": "$text"
}
EOF

}

case "$action" in
    start)
        start
        ;;
    next)
        next
        ;;
    print_current)
        print_current
        ;;
    stop)
        cleanup
        ;;
    *)
        exit 1
        ;;
esac


