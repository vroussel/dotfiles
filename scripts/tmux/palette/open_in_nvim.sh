#!/bin/bash
set -e

get_ssh_path() {
    cmd="$1"
    MAGIC_PROMPT_CHAR=" " #\u2005, special space
    SSH_PROMPT_PATTERN='^\w+@\w+:.* '

    x=$(tmux capture-pane -p -S '-' -J)
    last_prompt=$(echo "$x" | tac | grep -P --max-count 1 "$SSH_PROMPT_PATTERN") || exit 0
    user=$(echo "$last_prompt" | cut -d@ -f 1)
    server=$(echo "$last_prompt" | grep -Po "(?<=@).*(?=:)")
    path=$(echo "$last_prompt" | grep -Po "(?<=:).*(?=$MAGIC_PROMPT_CHAR)")

    path=${path/\~/'\$HOME'}

    echo "$user@$server/$path"
}

pid="$(tmux display-message -p '#{pane_pid}')"
pid="$(ps -o tpgid:1= -p "$pid")"
readarray -d '' cmd <"/proc/$pid/cmdline"
name="${cmd[0]}"
args=("${cmd[@]:1}")

if [[ "$name" == "/bin/bash" && "${args[0]}" == /home/valentin/bin/sshs ]] \
   || [[ "$name" == "/bin/bash" && "${args[0]}" == "-c" && "${args[1]}" =~ ^/home/valentin/bin/sshs ]]; then
    # extra_env=$(get_extra_env "${cmd[*]}")
    # no_extra_env=$(reset_extra_env)
    ssh_path=$(get_ssh_path "${cmd[*]}")
    tmux new-window -n "nvim ($ssh_path)" "nvim oil-ssh://$ssh_path"
fi
