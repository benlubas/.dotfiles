echo "deleting things"

rm -rf $HOME/.config/nvim
rm -rf $HOME/.config/ranger
rm -rf $HOME/.bashrc 
rm -rf $HOME/.gitconfig
rm -rf $HOME/.zshrc 
rm -rf $HOME/.config/tmux/tmux.conf
rm -rf $HOME/.config/alacritty.yml

echo "linking things"

ln -sv "$PWD/nvim $HOME/.config/nvim"
ln -sv "$PWD/ranger $HOME/.config/ranger"
ln -sv "$PWD/.bashrc $HOME/.bashrc" 
ln -sv "$PWD/.gitconfig $HOME/.gitconfig"
ln -sv "$PWD/.zshrc $HOME/.zshrc" 
mkdir -p $HOME/.config/tmux
ln -sv "$PWD/tmux.conf $HOME/.config/tmux/tmux.conf"
ln -sv "$PWD/alacritty.yml $HOME/.config/alacritty.yml"
