set fish_greeting
#set -gx SHELL /bin/fish

source ~/.aliases
delta --generate-completion fish | source

alias d cdh
bind \cz 'fg 2>/dev/null; commandline -f repaint'

fzf --fish | source
