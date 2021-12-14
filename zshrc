
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/Development/dotfiles/bin:$PATH

# Add android platformtools to path
export PATH=/Users/sreh/Library/Android/sdk/platform-tools:$PATH

# Add postgres bin tools
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Add pyenv bins to path
export PATH="$HOME/.pyenv/bin:$PATH"

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
plugins+=(zsh-completions)

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

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# terminal vim
bindkey -M viins 'jk' vi-cmd-mode  # @todo - THIS DOES NOT WORK?

# Immediately start each session in tmux
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

# Make vim default
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

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Prevents local TERM from affecting ssh.
alias ssh='TERM=xterm ssh'

# For compilers to find zlib you may need to set:
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

eval "$(fnm env --multi)"
