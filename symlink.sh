#!/usr/bin/bash

echo "deleting things"

rm -rfv $HOME/.config/nvim
rm -rfv $HOME/.config/ranger
rm -rfv $HOME/.config/i3

rm -rfv $HOME/.config/alacritty.yml
rm -rfv $HOME/.config/tmux/tmux.conf

rm -rfv $HOME/.bashrc 
rm -rfv $HOME/.gitconfig
rm -rfv $HOME/.zshrc 

echo "linking things"

mkdir -pv $HOME/.config
ln -sv $PWD/nvim $HOME/.config/nvim
ln -sv $PWD/ranger $HOME/.config/ranger
ln -sv $PWD/i3 $HOME/.config/i3

ln -sv $PWD/alacritty.yml $HOME/.config/alacritty.yml
mkdir -pv $HOME/.config/tmux
ln -sv $PWD/tmux.conf $HOME/.config/tmux/tmux.conf

ln -sv $PWD/.bashrc $HOME/.bashrc
ln -sv $PWD/.gitconfig $HOME/.gitconfig
ln -sv $PWD/.zshrc $HOME/.zshrc
