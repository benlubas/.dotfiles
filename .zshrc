# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.zshsecrets ]; then
  source $HOME/.zshsecrets
fi

if [ -f $HOME/.zshwork ]; then
  source $HOMe/.zshwork
fi

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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
alias gcaa="git commit -a --amend"
alias amend="git commit -a --amend --no-edit"

# grep only the files that changed on this branch from main, useful for making sure you're not forgetting anything
rgf() {
  branch=$(git branch --show-current)
  rg --no-messages "$@" $(git diff --name-only $branch $(git merge-base $branch main) | tr '\n' ' ')
}

syncnotes() {
  pushd ~/notes
  git add * && git commit -am "sync" && git pull && git push && popd && echo "notes synced" || echo "notes sync failed"
}

alias mx=tmux-sessionizer

# ============================================================= #

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# nix direnv (this should stay at the end)
eval "$(direnv hook zsh)"
