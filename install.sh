#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

RELEASE=$(lsb_release -is)
CONFIGDIR=~/.config
FILEDIR=$DIR/files

UBUNTUPACKAGES=( git curl scrot rofi ranger ncdu vim rxvt-unicode-256color zsh feh )
if [ $RELEASE == "Ubuntu" ]; then
        for i in "${UBUNTUPACKAGES[@]}"; do
                echo "### installing $i ###"

                sudo apt install --assume-yes $i > /dev/null 2>1
        done

fi


if [ ! -e ~/.fehbg ]; then
        ln -s $FILEDIR/fehbg ~/.fehbg
fi

if [ ! -e ~/Bilder/Wallpaper ]; then
        mkdir -p ~/Bilder/
        ln -s $FILEDIR/Wallpaper ~/Bilder/Wallpaper
fi

if [ ! -e $CONFIGDIR ]; then
        echo "### Creating $CONFIGDIR ###"
        mkdir ~/.config
else
        echo "### $CONFIGDIR exists. Doing nothing ###"
fi

#if [ ! -d ~/.dotfiles ]; then
#	echo "### Creating dotfiles directory ###"

#	mkdir ~/.dotfiles/

#fi
#ln -s $FILEDIR/emacs ~/.emacs.d
#ln -s $FILEDIR/i3 ~/.config/i3

# Setup rofi
rofi -v > /dev/null 2>1
if [ $? -ne 0 ]; then
        echo "### Installing rofi ###"
        if [ $LSBRELEASE == "Ubuntu" ]; then
                echo "### Installing for Ubuntu ###"
                sudo apt install rofi
        elif [ $RELEASE == "Arch" ]; then
                echo "### Installing for Arch ###"
                sudo pacman -S rofi
        fi
else
        echo "### rofi $(rofi -v) is installed"
fi

ROFIDIR=$CONFIGDIR/rofi
if [ ! -e $ROFIDIR ]; then
        echo "### Creating $ROFIDIR ###"
        mkdir $ROFIDIR
        ln -s $FILEDIR/rofi_config $ROFIDIR/config
else
        echo "### $ROFIDIR exists already. Doing nothing ###"
fi

# Setup i3
i3 -v > /dev/null 2>1
if [ $? -ne 0 ]; then
        echo "### Installing i3 ###"
        if [ $RELEASE == "Ubuntu" ]; then
                echo "### on Ubuntu"
                sudo add-apt-repository ppa:aguignard/ppa -y > /dev/null 2>1
                sudo apt-get update > /dev/null 2>1
                sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev --assume-yes > /dev/null 2>1

                if [ -e i3-gaps-next ]; then
                        rm -rf i3-gaps-next
                fi
                git clone https://github.com/Airblader/i3.git -b gaps-next i3-gaps-next
                cd i3-gaps-next
                autoreconf --force --install
                rm -rf build/
                mkdir -p build && cd build/
                ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
                make
                sudo make install
        elif [ $RELEASE == "Arch" ]; then
                echo "### on Arch ###"
                #TODO: Implement
        fi
else
        echo "### i3 already installed"
fi
                
I3DIR=$CONFIGDIR/i3
if [ ! -e $I3DIR ]; then
        echo "### Linking $FILEDIR/i3 to $I3DIR ###"
        ln -s $FILEDIR/i3 $I3DIR

else
        echo "### $I3DIR already exists. Doing nothing ###"
fi

i3lock -v > /dev/null 2>1
if [ $? -ne 0 ]; then
        echo "### Installing i3lock-color ###"
        sudo apt-get install pkg-config libxcb1 libpam-dev libcairo-dev libxcb-composite0 libxcb-composite0-dev libxcb-xinerama0-dev libev-dev libx11-dev libx11-xcb-dev libxkbcommon0 libxkbcommon-x11-0 libxcb-dpms0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xkb-dev libxkbcommon-x11-dev libxkbcommon-dev --assume-yes > /dev/null 2>1

        git clone https://github.com/chrjguill/i3lock-color.git i3lock-color
        cd i3lock-color
        make
        sudo make install

        git clone https://github.com/guimeira/i3lock-fancy-multimonitor.git
        mv i3lock-fancy-multimonitor ~/.i3
        chmod +x ~/.i3/i3lock-fancy-multimonitor/lock


else
        echo "### i3lock installed. Doing nothing ###"
fi



# Setup vim


VIMDIR=~/.vim
if [ ! -e $VIMDIR ];
then

	echo "### Creating Vim directory $VIMDIR ###"
	mkdir $VIMDIR
	mkdir $VIMDIR/bundle/
	git clone git://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
	git clone https://github.com/godlygeek/tabular.git ~/.vim/bundle/tabular
	git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
	git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
	git clone https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline

        git clone https://github.com/rodjek/vim-puppet.git ~/.vim/bundle/vim-puppet
        git clone https://github.com/hashivim/vim-vagrant.git

        mkdir $VIMDIR/autoload
        curl -LSso $VIMDIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim
        mkdir $VIMDIR/colors
        curl -LSso $VIMDIR/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
        mkdir $VIMDIR/swapfiles
        ln -s $FILEDIR/vim/snippets $VIMDIR/snippets

else
	echo "### $VIMDIR exists. Doing nothing ###"
fi	


VIMFILE=~/.vimrc
if [ ! -e $VIMFILE ];
then

	echo "### linking $FILEDIR/vimrc to $VIMFILE ###"
	ln -s $FILEDIR/vimrc $VIMFILE
else
        echo "### $VIMFILE exists. Doing nothing ###"
fi


# Setup Xdefaults
XDEFAULTS=~/.Xdefaults
if [ ! -e $XDEFAULTS ];
then

	echo "### linking $FILEDIR/xdefaults to $XDEFAULTS ###"
	ln -s $FILEDIR/vimrc $XDEFAULTS
else
        echo "### $XDEFAULTS exists. Doing nothing ###"
fi
