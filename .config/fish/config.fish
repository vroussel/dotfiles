set fish_greeting
#set -gx SHELL /bin/fish

source ~/.aliases
delta --generate-completion fish | source

alias d cdh

fzf --fish | source
bind \cw backward-kill-bigword
