# keys
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "''${key[Up]}" up-line-or-search

# show git stash icon
zstyle :prompt:pure:git:stash show yes
# highlight current tab selection
autoload -U compinit && compinit
zstyle ':completion:*' menu select
setopt autocd
setopt menucomplete

# history
setopt sharehistory
setopt hist_ignore_dups
setopt hist_find_no_dups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # antidote
  antidote_path=/home/benlubas/.antidote
  # homebrew - I'm not using this on NixOS
  # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  alias screen_cap="ffmpeg -select_region 1 -show_region 1 \
    -framerate 30 -f x11grab -i :0.0 \
    -pix_fmt +yuv420p -vf scale='-2:1080' \
    -movflags +faststart \
    -preset slower -y ~/Videos/screen_cap.mp4"
  alias copy="xclip -r -selection clipboard"
  alias paste="xclip -selection clipboard -o"
  # this only works b/c I've chowned the etc/nixos folder
  alias conf="nvim /etc/nixos/configuration.nix"
  alias rebuild="sudo nixos-rebuild switch"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # antidote
  antidote_path=/opt/homebrew/Cellar/antidote/1.9.0/share/antidote
  # homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # allow the magick rock to find ImageMagick
  export DYLD_LIBRARY_PATH=/opt/homebrew/lib/
else
  echo "[.zshrc] unknown OS - please add this OS to the ~/.zshrc file"
  exit 1
fi

zsh_plugins=$HOME/.zsh_plugins
source ${antidote_path}/antidote.zsh
antidote load

source ${zsh_plugins}.zsh

if [ -f $HOME/.zshsecrets ]; then
  source $HOME/.zshsecrets
fi

if [ -f $HOME/.zshwork ]; then
  source $HOME/.zshwork
fi

# bob
export PATH=$HOME/.local/share/bob/nvim-bin:$PATH

# fnm
export PATH=$HOME/.fnm:$PATH
eval "$(fnm env --use-on-cd)"

# rust-analyzer
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# personal scripts
export PATH=$HOME/github/.dotfiles/bin:$PATH

source $HOME/github/.dotfiles/zsh_extras.sh

export EDITOR="nvim"
export GIT_EDITOR="MD_MODE=1 nvim"
export COLOR_THEME="carbonfox"

# to use bat with man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ==== Aliases ==== #

alias v=nvim
alias kvm="ssh benlubas@login.ccs.neu.edu"
alias kvnvim="nvim oil-ssh://benlubas@login.ccs.neu.edu//home/benlubas/README.md"

alias gh="MD_MODE=1 gh" # pass this to nvim so that I can set a few custom config options
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gd="git diff"
alias gdm="git diff --merge-base main"
alias gc="git checkout"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gl="git log --oneline --decorate --graph"
alias gcam="git commit -am"
alias amend="git commit --amend"
alias pull="git pull"
alias push="git push"

alias ls="ls --color"
alias la="ls -la"

# grep only the files that changed on this branch from main, useful for making sure you're not forgetting anything
grg() {
  branch=$(git branch --show-current)
  rg --no-messages "$@" $(git diff --name-only $branch $(git merge-base $branch main) | tr '\n' ' ')
}

syncnotes() {
  pushd ~/notes
  git add * && (git diff-index --quiet HEAD || git commit -am "sync") && git pull && git push && popd && echo "notes synced" || echo "notes sync failed"
}

alias mx=tmux-sessionizer
alias tx=tmux-sessions

# direnv
eval "$(direnv hook zsh)"
