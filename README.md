# .dotfiles

Here are all the dotfiles that I use, I'm going to keep this up to date with the things that I use 
for NVIM, and maybe my zshrc and stuff like that. 


The more important thing in here is going to be this readme, which will contain 
all the information needed to setup a new machine. 


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
  - `chmod +x ~/github/.dotfiles/symlink.py `
  - `~/github/.dotfiles/symlink.py`
  - `source ~/.zshrc`

4. Check that that worked: 
  - The script should have deleted the current dotfiles (ie. ~/.zshrc) and replaced the with symlinked 
  versions which live in the git repo. so to check that, run:
    - `ls -la` and make sure you see symlinks in the right places

5. Brew
  - install [Homebrew](https://brew.sh)
  - `brew file install`

6. Things that aren't on Brew
  - Svelte Language Server 
  - probably more that I'll find later. 

7. NVIM
  - You should be able to just run `v` to launch nvim
  - open `~/.config/nvim/lua/benlubas/packer.lua` 
    - `:so` to source the file. 
    - `:PackerSync` to install all the plugins and themes 
  - relaunch nvim 
  - install Jetbrains font from [Nerdfonts](https://www.nerdfonts.com/font-downloads)


TODO: I still need to figure out the best way to handle oh-my-zsh, Not sure if I can just add a couple folders to this repo
and call it a day or what. 
