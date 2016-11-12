#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

mkdir ~/.config/

ln -s $DIR/emacs ~/.emacs.d
ln -s $DIR/i3 ~/.config/i3





