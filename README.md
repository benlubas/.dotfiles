# .dotfiles

All the things

Probably gonna rewrite this with nix in mind at some point

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
```bash 
chmod +x ~/github/.dotfiles/symlink.sh
~/github/.dotfiles/symlink.sh
source ~/.zshrc
```

4. Check that that worked: 
  - The script should have deleted the current dotfiles (ie. ~/.zshrc) and 
  replaced the with symlinked versions which live in the git repo. so to check that, run:
    - `ls -la` and make sure you see symlinks in the right places

5. Things that you shouldn't/can't install with brew
  - [Rust](https://rust-land.com/install) the brew way will mess with `rustup` which is 
  annoying for updating and switching between versions.

6. NVIM
  - install it somehow
  - You should be able to just run `v` to launch nvim
  - Deps
    - install JetBrains font from [Nerdfonts](https://www.nerdfonts.com/font-downloads)
      - set that as the default terminal font
    - ripgrep `cargo install ripgrep`
    - working with ruby? install solargraph yourself
    - possibly others that I'm forgetting.

7. Alacritty

