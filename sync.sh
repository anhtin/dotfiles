#!/usr/bin/bash

FILES=(
    '.vimrc'
    '.zshrc'
    '.zimrc'
    '.tmux.conf'
    '.chunkwmrc'
    '.skhdrc'
)
FOLDERS=(
    '.hammerspoon'
)

for file in ${FILES[@]}; do
    echo "Linking file '$file'..."
    ln -i -s $HOME/dotfiles/$file $HOME/$file
done
for folder in ${FOLDERS[@]}; do
    echo "Linking folder '$folder'..."
    ln -i -s $HOME/dotfiles/$folder $HOME/$folder
done
