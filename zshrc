# Add postgres bin tools
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Add zellij tools
export PATH=$HOME/Development/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vi-mode git-flow history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# zsh completions
plugins+=(zsh-completions)
autoload -U compinit && compinit


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

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Add pyenv bins to path and activate it
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# terminal vim
bindkey -M viins 'jk' vi-cmd-mode  # @todo - THIS DOES NOT WORK?


# Make nvvim default
export VISUAL=nvim
export EDITOR="$VISUAL"

# For docker completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sebastianrehm/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sebastianrehm/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sebastianrehm/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sebastianrehm/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


# Prevents local TERM from affecting ssh.
alias ssh='TERM=xterm ssh'

# For compilers to find zlib you may need to set:
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

eval "$(fnm env)"
fpath=($fpath "/Users/sebastian/.zfunctions")
