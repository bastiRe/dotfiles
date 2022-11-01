# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/Development/dotfiles/bin:$PATH

# setup local bin's (necessary for lunar vim)
export PATH=$HOME/.local/bin:$PATH

# Add postgres bin tools
# export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Add pyenv bins to path
# export PATH="$HOME/.pyenv/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git history-substring-search)
# plugins+=(zsh-completions)


source $ZSH/oh-my-zsh.sh

# Export correct language
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# FZF config
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf + rg configuration
if _has fzf && _has rg; then
  export FZF_DEFAULT_COMMAND='rg --nocolor --ignore node_modules -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# terminal vim
bindkey -M viins 'jk' vi-cmd-mode  # @todo - THIS DOES NOT WORK?

# Make vim default
export VISUAL=nvim
export EDITOR="$VISUAL"

# For docker completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i


# Prevents local TERM from affecting ssh.
alias ssh='TERM=xterm ssh'



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.rbenv/bin:$PATH"

# Android Emulator Config
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
source /opt/homebrew/opt/spaceship/spaceship.zsh

. /opt/homebrew/opt/asdf/libexec/asdf.sh
