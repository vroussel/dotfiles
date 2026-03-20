#!/bin/bash
set -e

pid="$(tmux display-message -p '#{pane_pid}')"
pid="$(ps -o tpgid:1= -p "$pid")"
dir="$(readlink -f "/proc/$pid/cwd")"
cd -- "${dir:?}"
exe="$(readlink -f "/proc/$pid/exe")"
readarray -d '' args <"/proc/$pid/cmdline"
name="${args[0]}"
args=("${args[@]:1}")

if [ "$name" == "/bin/ssh" ]; then
    tmux "$@" -c "$dir" bash -c "${exe@Q} ${args[*]@Q}; bash"
elif [[ "$name" == "bash" && "${args[0]}" == "-c" && "${args[1]}" =~ ^\'?/usr/bin/ssh.* ]]; then
    tmux "$@" -c "$dir" bash -c "${args[1]}"
else
    tmux "$@" -c "$dir" bash
fi
