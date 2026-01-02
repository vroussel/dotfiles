# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=15000
HISTFILESIZE=200000
HISTIGNORE="ls:ll:fg"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias grep='grep --color=auto'
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    screen|xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

################
# PROMPT / PS1 #

# Git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
source "$HOME/scripts/git-prompt.sh"

RED="$(echo -en "\033[1;31m")"
GREEN="$(echo -en "\033[1;32m")"
BLUE="$(echo -en "\033[1;34m")"
RESET="$(echo -en "\033[0m")"
MAGIC_SPACE=" " #\u2005, special space in order to be able to jump to previous/next prompt
if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[${BLUE}\]\w\[${RESET}\]\$(__git_ps1)\[${RESET}\]${MAGIC_SPACE}\$([ \$? == 0 ] || echo '\[${RED}\]')\$ \[${RESET}\]"
else
    PS1='${debian_chroot:+($debian_chroot)}\w${MAGIC_SPACE}\$ '
fi
unset color_prompt force_color_prompt

#dynamic window title
window_title="cwd=\$PWD"
PS1="\[\033]0;${window_title}\a\]$PS1" #window title

## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1

source ~/.git-prompt.sh

#save PWD at each command
PROMPT_COMMAND='[ -d "${XDG_RUNTIME_DIR}" ] && pwd > "${XDG_RUNTIME_DIR}/.cwd"'

# Set GCC option to color output
export GCC_COLORS='error=01;31:warning=01;33:note=01;34:caret=05;32:locus=0;32:quote=0;92'

alias t=todo.sh

#source /usr/share/doc/fzf/examples/key-bindings.bash
export FZF_DEFAULT_COMMAND='fd --type f'

## FZF
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.bash"
source "/usr/share/bash-completion/completions/todo.sh"
complete -F _todo t
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi


stty -ixon
shopt -s checkjobs

function _edit_wo_executing() {
    local editor="${EDITOR:-vim}"
    tmpf="$(mktemp)"
    printf '%s\n' "$READLINE_LINE" > "$tmpf"
    "$editor" "$tmpf"
    READLINE_LINE="$(<"$tmpf")"
    READLINE_POINT="${#READLINE_LINE}"
    rm "$tmpf"
}

function dedup(){
    declare -a new=() copy=("${DIRSTACK[@]:1}")
    declare -A seen
    local v i
    seen[$PWD]=1
    for v in "${copy[@]}"
    do if [ -z "${seen[$v]}" ]
       then new+=("$v")
            seen[$v]=1
       fi
    done
    dirs -c
    for ((i=${#new[@]}-1; i>=0; i--))
    do      builtin pushd -n "${new[i]}" >/dev/null
    done
}

function cd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null || return $?
  dedup
}

alias d='dirs -v'
for index in {0..9}; do alias "$index"="cd +${index}"; done; unset index;

bind -x '"\C-x\C-e":_edit_wo_executing'
bind "set skip-completed-text on"
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind 'set show-all-if-unmodified on'
bind 'set colored-completion-prefix on'
bind 'set colored-stats'
bind '"\ej": menu-complete'
bind '"\ek": menu-complete-backward'
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'
bind -x '"\C-z":"fg >/dev/null 2>&1"'

##########



######
# MISC

######



# Run fish
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && -z ${debian_chroot} ]]
then
	exec fish
fi
