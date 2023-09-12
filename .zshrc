# keys
bindkey -e
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

# antidote
antidote_path=/opt/homebrew/Cellar/antidote/1.9.0/share/antidote # this path will change on linux
zsh_plugins=$HOME/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source ${antidote_path}/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

if [ -f $HOME/.zshsecrets ]; then
  source $HOME/.zshsecrets
fi

if [ -f $HOME/.zshwork ]; then
  source $HOME/.zshwork
fi

# homebrew
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm
export PATH=$HOME/.fnm:$PATH
eval "$(fnm env --use-on-cd)"

# rust-analyzer
export PATH=$HOME/.local/bin:$PATH

# personal scripts
export PATH=$HOME/github/.dotfiles/bin:$PATH

export EDITOR="nvim"

# to use bat with man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ==== Aliases ==== #

alias v=nvim
alias kvm="ssh benlubas@login.ccs.neu.edu"
alias kvnvim="nvim oil-ssh://benlubas@login.ccs.neu.edu//home/benlubas/README.md"

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
alias amend="git commit -a --amend"

# grep only the files that changed on this branch from main, useful for making sure you're not forgetting anything
rgf() {
  branch=$(git branch --show-current)
  rg --no-messages "$@" $(git diff --name-only $branch $(git merge-base $branch main) | tr '\n' ' ')
}

syncnotes() {
  pushd ~/notes
  git add * && (git diff-index --quiet HEAD || git commit -am "sync") && git pull && git push && popd && echo "notes synced" || echo "notes sync failed"
}

alias mx=tmux-sessionizer
