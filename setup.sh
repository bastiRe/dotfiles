#!/bin/sh -e
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# setup brew in path
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/srehm/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/srehm/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Brew install bundle
brew bundle install

# Install node via asdf
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add python
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git


# Install latest versions via asdf and make global
asdf install nodejs latest && asdf global nodejs latest
asdf install ruby latest && asdf global ruby latest



# Symlink configs
ln -f -s "$(pwd)/zshrc" ~/.zshrc 
ln  -s -f "$(pwd)/kitty" ~/.config

$(brew --prefix)/opt/fzf/install

# Install oh-my-zsh
{ 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
} || {
  echo "oh-my-zsh install failed"
}

# Install zsh-completions and syntax-highlighting
{ 
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
} || {
  echo "zsh completions install failed"
}

# Setup fzf correcty
$(brew --prefix)/opt/fzf/install

