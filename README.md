# dotfiles
Yet another dotfiles repo

Based on
https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained

## Installing
```sh
git clone <remote-git-repo-url> $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout $HOME
```
