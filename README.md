# .dotfiles

All the things

At some point I might rewrite this in nix... I'm not sure.

More about my neovim setup [here](./nvim/README.md).

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
Note: sourcing zshrc is probably going to fail the first time you try it

## Mac

quickly install almost everything with `brew bundle --file=./Brewfile`

Install rust separately
  - [Rust](https://rust-land.com/install) the brew way will mess with `rustup` which is
  annoying for updating and switching between versions.
## Nixos

- Go clone [my nix config](https://github.com/benlubas/nix-config)

## Both (for now)

- [Antidote](https://github.com/mattmc3/antidote) for zsh plugins, I might package these on nix at
some point
- Neovim plugins are managed by lazy, they should auto install on launch. You're mostly on your own
  for language servers.
