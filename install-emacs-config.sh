#!/bin/bash

# get the script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# backup the files (if they exist)
date=$(date +'%m-%d-%Y')
if [ -f ~/.emacs ]; then 
    echo ".emacs exists, moving to ~/.emacs.bak_$date"
    mv ~/.emacs ~/.emacs.bak_$date; 
fi

if [ -d ~/.emacs.d/ ]; then  
    echo ".emacs.d exists, moving to ~/.emacs.d.bak_$date"
    mv ~/.emacs.d ~/.emacs.d.bak_$date; 
fi

# make a fresh new folder
mkdir -p ~/.emacs.d/

# add make symlinks
ln -s $DIR/mylisp ~/.emacs.d/
ln -s $DIR/dot-emacs-config ~/.emacs.d/
ln -s $DIR/dotemacs.el ~/.emacs
