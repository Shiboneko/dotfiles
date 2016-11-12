#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
	    exit
fi
pacman -S puppet
puppet apply init.pp

mkdir ~/.emacs.d/
mkdir ~/.config/

