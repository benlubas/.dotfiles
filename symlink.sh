#!/usr/bin/env bash

echo "deleting things"

rm -rfv $HOME/.config/nvim
rm -rfv $HOME/.config/ranger
rm -rfv $HOME/.config/polybar
rm -rfv $HOME/.config/rofi
rm -rfv $HOME/.config/i3
rm -rfv $HOME/.config/dunst

rm -rfv $HOME/.config/alacritty.yml
rm -rfv $HOME/.config/wezterm/wezterm.lua
rm -rfv $HOME/.config/kitty/kitty.conf
rm -rfv $HOME/.config/tmux/tmux.conf

rm -rfv $HOME/.bashrc
rm -rfv $HOME/.gitconfig
rm -rfv $HOME/.xprofile
rm -rfv $HOME/.zshrc
rm -rfv $HOME/.p10k.zsh
rm -rfv $HOME/.zsh_plugins.txt

echo "linking things"

mkdir -pv $HOME/.config

ln -sv $PWD/nvim $HOME/.config/nvim
ln -sv $PWD/ranger $HOME/.config/ranger
ln -sv $PWD/polybar $HOME/.config/polybar
ln -sv $PWD/rofi $HOME/.config/rofi
ln -sv $PWD/i3 $HOME/.config/i3
ln -sv $PWD/dunst $HOME/.config/dunst

ln -sv $PWD/alacritty.yml $HOME/.config/alacritty.yml
mkdir -pv $HOME/.config/tmux
ln -sv $PWD/tmux.conf $HOME/.config/tmux/tmux.conf
mkdir -pv $HOME/.config/wezterm
ln -sv $PWD/wezterm.lua $HOME/.config/wezterm/wezterm.lua
mkdir -pv $HOME/.config/kitty
ln -sv $PWD/kitty.conf $HOME/.config/kitty/kitty.conf

ln -sv $PWD/.bashrc $HOME/.bashrc
ln -sv $PWD/.gitconfig $HOME/.gitconfig
ln -sv $PWD/.xprofile $HOME/.xprofile
ln -sv $PWD/.zshrc $HOME/.zshrc
ln -sv $PWD/.p10k.zsh $HOME/.p10k.zsh
ln -sv $PWD/.zsh_plugins.txt $HOME/.zsh_plugins.txt
