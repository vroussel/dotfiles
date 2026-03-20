# dotfiles
Yet another dotfiles repo

Based on
https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained

##Installing
1. git clone <remote-git-repo-url> $HOME/dotfiles
2. alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
3. config config --local status.showUntrackedFiles no
4. config checkout $HOME

## Python lsp stuff
$ sudo pacman -S python-lsp-server python-lsp-black
$ aur sync python-pyls-isort
$ sudo pacman -S python-pyls-isort
