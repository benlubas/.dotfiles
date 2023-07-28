# .dotfiles

All the things

At some point I might rewrite this in nix... I'm not sure.

## New Machine Setup
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
```
Note: sourcing zsh rc is probably going to fail the first time you try it

6. [Homebrew](https://brew.sh/) (mac only due to the use of cask)
  - quickly install almost everything with `brew bundle --file=./Brewfile`
  - this installs nvim, alacritty, and the jetbrains mono nerd font

5. Rust (shouldn't install with brew)
  - [Rust](https://rust-land.com/install) the brew way will mess with `rustup` which is
  annoying for updating and switching between versions.

6. NVIM
  - install it somehow
  - You should be able to just run `v` to launch nvim
  - Deps
    - install JetBrains font from [Nerdfonts](https://www.nerdfonts.com/font-downloads)
      - set that as the default terminal font
    - A bunch of language servers need to be installed with `:Mason`
    - Run `:checkhealth` and see if I forgot something

7. Alacritty
  - install it somehow

8. [Antidote](https://github.com/mattmc3/antidote) for zsh

9. Tmux and [TPM](https://github.com/tmux-plugins/tpm)
  - If you're on a mac, follow [this](https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95)

## TODO:
- [x] Sync branches
- [ ] Moonfly theme for `bat` (and as a result, git delta)
- [ ] nix? maybe one day

See also the [nvim TODO items](./nvim/notes.md)
