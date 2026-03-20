# dotfiles
Yet another dotfiles repo

Based on
https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained

##Installing
1. git clone <remote-git-repo-url> $HOME/dotfiles
2. alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
3. config config --local status.showUntrackedFiles no
4. config checkout $HOME

## Share Vim and Neovim conf
$ ln -s ~/.vim ~/.local/share/nvim/site
$ ln -s ~/.vimrc ~/.config/nvim/init.vim

## Extra steps
pip install --user python-lsp-server[rope,pyflakes,mccabe,pycodestyle,pydocstyle]
pip install --user python-lsp-black pyls-flake8 pyls-isort
pacman -S fzf
pacman -S fd
