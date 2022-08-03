# .dotfiles

Here are all the dotfiles that I use, I'm going to keep this up to date with the things that I use for NVIM, and maybe my zshrc and stuff like that. 


The more important thing in here is going to be this readme, which will contain all the information needed to setup a new machine. 


## Setup 
1. Add a new SSH key for Github 
  - `ssh-keygen -t ed25519 -C "benmlubas@gmail.com"`
    - Use the default file
  - `eval "$(ssh-agent -s)"` 
  - `ssh-add ~/.ssh/id_ed25519`
  - `cat ~/.ssh/id_ed25519.pub` => copy that
  - (github.com)[https://www.github.com/settings/keys]
    - add the key, give it a name

2. Clone this repo
  - `git clone git@github.com:benlubas/.dotfiles.git ~/github/.dotfiles`

3. Run the symlink script
  - `chmod ~/github/.dotfiles/symlink.sh -711`
  - `~/github/.dotfiles/symlink.sh`
  - This should resource ~/.zshrc, and you will have to download oh-my-zsh again tho... I should add that to the script.. or something 

4. Check that that worked: 
  - The script should have deleted the current dotfiles (ie. ~/.zshrc) and replaced the with symlinked 
  versions which live in the git repo. so to check that, run:
    - `ls -la` and make sure you see symlinks in the right places

5. Let's get nvim working 
  - You should be able to just run `v` to launch netrw
  - open `~/.config/nvim/lua/benlubas/packer.lua` 
  - run `:PackerSync` 
    - that should install all the plugins and themes 
  - relaunch nvim 
