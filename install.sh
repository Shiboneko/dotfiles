#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKDIR="$DIR/backup/dotfiles/$(date "+%Y_%m_%d-%H_%M_%S")/"
RELEASE=$(lsb_release -is)
CONFIGDIR=~/.config
FILEDIR=$DIR/files

UBUNTUPACKAGES=( git curl scrot rofi ranger ncdu vim rxvt-unicode-256color zsh feh )

e_header()   { echo -e "\n\033[1m$@\033[0m"; }
e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

e_git () {
        GITURL=$1
        DEST=$2
        e_header "Cloning $GITURL to $DEST"

        if [ -e $DEST ]; then
                backup $DEST
        fi
        git clone $GITURL $DEST > /dev/null 2>1
        e_success "$GITURL cloned to $DEST"

}


link () {

        SOURCE=$1
        DEST=$2

                e_header "Linking $SOURCE to $DEST"

        if test "$SOURCE" -ef "$DEST" ; then
                e_success "$SOURCE"
        else
                if [ -e "$DEST" ];
                then
                        backup "$DEST" "$BACKDIR"
                fi
                rm $DEST
                ln -s "$SOURCE" "$DEST"
                e_success "$SOURCE"

        fi

}

create() {


        TARGET=$1

        if [ ! -e $TARGET ]; then
                e_header "Creating $TARGET"
                mkdir -p "$TARGET"
                e_success
        fi

        e_success "$TARGET created"

}


backup () {

        FILE=$1
        e_header "Backing up $FILE"
        BASE=$(basename $FILE)
        e_arrow "Using $BASE as Folder"
        if [ ! -e "$BACKDIR/$BASE" ]; then
                e_arrow "Creating $BACKDIR/$BASE"
                mkdir -p "$BACKDIR/$BASE"
        fi

        e_arrow "Moving file to $BACKDIR/$BASE"

        mv "$FILE" "$BACKDIR/$BASE"

}

install_packages () {
        if [ $RELEASE == "Ubuntu" ]; then
                for i in "${UBUNTUPACKAGES[@]}"; do
                        e_header "installing $i via apt"

                        sudo apt install --assume-yes $i > /dev/null 2>1
                done

        fi


}


link $FILEDIR/fehbg ~/.fehbg

create ~/Bilder/
link $FILEDIR/Wallpaper ~/Bilder/Wallpaper


create $CONFIGDIR

ROFIDIR=$CONFIGDIR/rofi
create $ROFIDIR
link $FILEDIR/rofi_config $ROFIDIR/config

# Setup i3
i3 -v > /dev/null 2>1
if [ $? -ne 0 ]; then
        e_header "Installing i3"
        if [ $RELEASE == "Ubuntu" ]; then
                e_arrow "on Ubuntu"
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
                e_header "on Arch"
                #TODO: Implement
        fi
else
        e_success "i3 already installed"
fi

I3DIR=$CONFIGDIR/i3
link $FILEDIR/i3 $I3DIR


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

create $VIMDIR
create $VIMDIR/bundle/
create $VIMDIR/autoload
create $VIMDIR/colors
create $VIMDIR/swapfiles
link $FILEDIR/vim/snippets $VIMDIR/snippets

e_git git://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
e_git https://github.com/godlygeek/tabular.git ~/.vim/bundle/tabular
e_git https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
e_git https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
e_git https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline
e_git https://github.com/tfnico/vim-gradle
e_git https://github.com/rodjek/vim-puppet.git ~/.vim/bundle/vim-puppet
e_git https://github.com/hashivim/vim-vagrant.git $VIMDIR/bundle/vim-vagrant

curl -LSso $VIMDIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -LSso $VIMDIR/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim


VIMFILE=~/.vimrc
link $FILEDIR/vimrc $VIMFILE


# Setup Xdefaults
XDEFAULTS=~/.Xdefaults

link $FILEDIR/Xdefaults $XDEFAULTS

