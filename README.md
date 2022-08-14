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
    - [github.com](https://www.github.com/settings/keys)
        - add the key, give it a name

2. Clone this repo
    - `git clone git@github.com:benlubas/.dotfiles.git ~/github/.dotfiles`

3. Run the symlink script
    - does it have to do with the first text?
    - `chmod +x ~/github/.dotfiles/symlink.py `
    - `~/github/.dotfiles/symlink.py`
    - `source ~/.zshrc` 
    - What is this?

4. Check that that worked: 
    - The script should have deleted the current dotfiles (ie. ~/.zshrc) and 
    replaced the with symlinked versions which live in the git repo. so to check that, run:
        - `ls -la` and make sure you see symlinks in the right places

5. Brew
    - install [Homebrew](https://brew.sh)
    - `brew file install`

6. Things that you shouldn't/can't install with brew
    - [Rust](https://rust-land.com/install) the brew way will mess with `rustup` which is 
    annoying for updating and switching between versions.

7. NVIM
    - You should be able to just run `v` to launch nvim
    - Go install packer, and while you're at it add the line that will auto install
    the plugin manager when running nvim for the first time. That would be helpful.
    - open `~/.config/nvim/lua/benlubas/packer.lua` 
        - `:so` to source the file. 
        - `:PackerSync` to install all the plugins and themes 
        - This step will install all the language servers too
        - relaunch nvim 
    - install JetBrains font from [Nerdfonts](https://www.nerdfonts.com/font-downloads)
        - set that as the default terminal font

8. Alacritty if you want to. Best option on windows. 
    - The config file has size and position specified, that's setup for a 1440p monitor 
    and it'll almost certainly go off the screen on a 1080p one. Keep that in mind

TODO: Need to figure out if there's an easy way for oh-my-zsh configuration and 
functionality to get brought along. 
