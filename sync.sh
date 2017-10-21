#!/usr/bin/bash

FILES=(
    '.vimrc'
    '.zshrc'
    '.zimrc'
    '.tmux.conf'
    '.hammerspoon'
)

for file in ${FILES[@]}; do
    ln -i -s $file $HOME/$file
done
