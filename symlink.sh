echo "deleting things"

rm -rfv $HOME/.config/nvim
rm -rfv $HOME/.config/ranger

rm -rfv $HOME/.config/alacritty.yml
rm -rfv $HOME/.config/tmux/tmux.conf

rm -rfv $HOME/.bashrc 
rm -rfv $HOME/.gitconfig
rm -rfv $HOME/.zshrc 

echo "linking things"

ln -sv "$PWD/nvim $HOME/.config/nvim"
ln -sv "$PWD/ranger $HOME/.config/ranger"

ln -sv "$PWD/alacritty.yml $HOME/.config/alacritty.yml"
ln -sv "$PWD/tmux/tmux.conf $HOME/.config/tmux/tmux.conf"

ln -sv "$PWD/.bashrc $HOME/.bashrc" 
ln -sv "$PWD/.gitconfig $HOME/.gitconfig"
ln -sv "$PWD/.zshrc $HOME/.zshrc" 
