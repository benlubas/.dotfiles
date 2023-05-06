# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

export COLORTERM=truecolor

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fnm rust zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# --- end of oh-my-zsh --- #

export PATH=$HOME/github/.dotfiles/bin:$PATH

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

if [ -f $HOME/.zshsecrets ]; then
  source $HOME/.zshsecrets
fi

export EDITOR="nvim"
export LC_CTYPE=en_US.UTF-8

# to use bat with man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias v="nvim"

lelloi() {
  cd $HOME/work/lello
  bundle install &
  yarn install &

  cd $HOME/work/lello/partners
  bundle install &
  wait

  cd $HOME/work/lello
  bundle exec rails db:migrate:primary
  bundle exec rails db:migrate:primary RAILS_ENV=test
  bundle exec rails db:migrate:partner_service
  bundle exec rails db:migrate:partner_service RAILS_ENV=test
  cd $HOME/work/lello/partners
  bundle exec rails app:db:migrate:primary
  bundle exec rails app:db:migrate:partner_service
  cd $HOME/work/lello
}

rgf() {
  branch=$(git branch --show-current)
  rg --no-messages "$@" $(git diff --name-only $branch $(git merge-base $branch main) | tr '\n' ' ')
}

alias gs="git status"
alias zshrc="$EDITOR ~/.zshrc"
alias ga="git add"
alias gd="git diff"
alias gdm="git diff --merge-base main"
alias gc="git checkout"
alias gcm="git checkout main"
alias gcb="git checkout -b"
alias gcam="git commit -am"
# git clean is now a command (kinda hacky but)
alias clean="remote prune origin; git branch -vv | awk '/: gone]/' | cut -d' ' -f3 | xargs git branch -D"

alias railsc="bundle exec rails c"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
export PATH=/home/benlubas/.fnm:$PATH
eval "`fnm env`"

# rust-analyzer 
export PATH=/home/benlubas/.local/bin:$PATH

alias mx="$HOME/github/.dotfiles/bin/tmux_sessionizer"

export CC="/usr/bin/gcc"

export ZSH_TMUX_AUTOSTART="true"
export LC_ALL="en_US.UTF-8"

# brew less
export PATH="/opt/homebrew/opt/less/bin:$PATH"

eval "$(direnv hook zsh)" >> /dev/null
