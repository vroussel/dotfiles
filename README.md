# dotfiles
Yet another dotfiles repo

#TODO script symlink creation

## List of files:
 - i3/config            => ~/.config/i3/config
 - terminator/config    => ~/.config/terminator/config
 - i3/i3_*              => ~/.i3/
 - vim/.vimrc           => ~/.vimrc
 - vim/colors           => ~/.vim/colors
 - vim/autoload         => ~/.vim/autoload
 - git/.gitconfig       => ~/.gitconfig
 - i3blocks/config      => ~/.config/i3blocks/config
 - i3blocks/blocklets   => ~/.config/i3blocks/blocklets

## Share Vim and Neovim conf
$ ln -s ~/.vim ~/.local/share/nvim/site
$ ln -s ~/.vimrc ~/.config/nvim/init.vim
