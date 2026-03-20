# dotfiles
Yet another dotfiles repo

Based on
https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained

##Installing
1. echo "dotfiles" >> .gitignore
2. git clone <remote-git-repo-url> $HOME/dotfiles
3. alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
4. config config --local status.showUntrackedFiles no
5. config checkout $HOME

## Share Vim and Neovim conf
$ ln -s ~/.vim ~/.local/share/nvim/site
$ ln -s ~/.vimrc ~/.config/nvim/init.vim
