export PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"
export TERMINAL="alacritty.sh"
export EDITOR=/usr/bin/nvim
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PAGER=/sbin/less

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
