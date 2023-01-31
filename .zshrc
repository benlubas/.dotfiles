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

if [ -f $(brew --prefix)/etc/brew-wrap ];then
    source $(brew --prefix)/etc/brew-wrap
fi

# --- end of oh-my-zsh --- #

if [ -f $(pwd)/.zshsecrets ]; then
  source $(pwd)/.zshsecrets
fi

export EDITOR="nvim"

v() {
  if [ ! -z "$1" ]; then 
    $EDITOR "$1"
  else 
    $EDITOR .
  fi
}

alias zshrc="$EDITOR ~/.zshrc"
alias gs="git status"
alias gd="git diff"
alias gdm="git diff main"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm
export PATH=/home/benlubas/.fnm:$PATH
eval "`fnm env`"

# rust-analyzer 
export PATH=/home/benlubas/.local/bin:$PATH

# If a session exists, attach to it. 
# Otherwise, create a new one and set it up 
alias mx="tmux attach -t \"(╯°□°）╯︵ ┻━┻)\" || \
  tmux new-session -s \"(╯°□°）╯︵ ┻━┻)\"\; \
  rename-window \"Main Nvim\" \; \
  neww -n shell \; \
  select-window -t 0 \; \
  send-keys 'cd ~/work/ && clear' C-m \;"

export CC="/usr/bin/gcc"

export ZSH_TMUX_AUTOSTART="true"
export LC_ALL="en_US.UTF-8"

# export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

eval "$(direnv hook zsh)" >> /dev/null
