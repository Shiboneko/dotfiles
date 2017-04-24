#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

if [ ! -d ~/.dotfiles ]; then
	echo "### Creating dotfiles directory ###"

	mkdir ~/.dotfiles/

fi
#ln -s $DIR/emacs ~/.emacs.d
#ln -s $DIR/i3 ~/.config/i3

# Setup rofi


# Setup vim

if [ -e ~/.vim ];
then

	echo "### Creating Vim directory ###"
	mkdir ~/.vim
	mkdir ~/.vim/bundle/
	git clone git://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
	git clone https://github.com/godlygeek/tabular.git ~/.vim/bundle/tabular
	git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
	git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
	git clone https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline
	git clone https://github.com/rodjek/vim-puppet.git ~/.vim/bundle/vim-puppet
fi	


if [ -e ~/.vimrc ];
then

	echo "### linking ~/.dotfiles/vimrc to ~/.vimrc ###"
	ln -s ~/.dotfiles/vimrc ~/.vimrc
fi
