#!/bin/bash
set -e

get_extra_env() {
    cmd="$1"
    ret=""
    MAGIC_PROMPT_CHAR=" " #\u2005, special space
    SSH_PROMPT_PATTERN='^\w+@\w+:.* '

    x=$(tmux capture-pane -p -S '-' -J)
    last_prompt=$(echo "$x" | tac | grep -P --max-count 1 "$SSH_PROMPT_PATTERN") || exit 0
    user=$(echo "$last_prompt" | cut -d@ -f 1)
    path=$(echo "$last_prompt" | grep -Po "(?<=:).*(?=$MAGIC_PROMPT_CHAR)")

    ret+="SSHS_CWD=$path"
    if ! [[ "$cmd" =~ (-l\ $user)|($user@) ]]; then
        ret+=" SSHS_SUDO_USER=$user"
    fi
    echo "$ret"
}

reset_extra_env() {
    echo "-u SSHS_CWD -u SSHS_SUDO_USER"
}

pid="$(tmux display-message -p '#{pane_pid}')"
pid="$(ps -o tpgid:1= -p "$pid")"
dir="$(readlink -f "/proc/$pid/cwd")"
readarray -d '' cmd <"/proc/$pid/cmdline"
name="${cmd[0]}"
args=("${cmd[@]:1}")

if [[ "$name" == "/bin/bash" && "${args[0]}" == /home/valentin/bin/sshs ]]; then
    extra_env=$(get_extra_env "${cmd[*]}")
    no_extra_env=$(reset_extra_env)
    tmux "$@" env $extra_env /bin/bash -c "${args[*]}; env $no_extra_env bash"
elif [[ "$name" == "/bin/bash" && "${args[0]}" == "-c" && "${args[1]}" =~ ^/home/valentin/bin/sshs ]]; then
    extra_env=$(get_extra_env "${cmd[*]}")
    tmux "$@" env $extra_env /bin/bash -c "${args[*]:1}"
else
    tmux "$@" -c "$dir" "${cmd[*]}"
fi
