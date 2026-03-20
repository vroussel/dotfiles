set fish_greeting
#set -gx SHELL /bin/fish

source ~/.aliases

alias d cdh
bind \cz 'fg 2>/dev/null; commandline -f repaint'

fzf --fish | source
