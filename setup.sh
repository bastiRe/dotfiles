#!/bin/sh -e

# Add necesseray dependencies
brew install tmux neovim fzf zsh-completions reattach-to-user-namespace python3

# Install oh-my-zsh
{ 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
} || {
  echo "oh-my-zsh install failed"
}

npm install -g spaceship-prompt

# Install python support for neovim
pip3 install --user neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Symlink configs
ln -f -s "$(pwd)/zshrc" ~/.zshrc 
ln -f -s "$(pwd)/tmux.conf" ~/.tmux.conf 
ln -f -s "$(pwd)/vimrc" ~/.vimrc 

mkdir ~/.config/nvim
touch ~/.config/nvim/init.vim
ln -f -s "$(pwd)/vimrc" ~/.config/nvim/init.vim

# Add terminfo for italics in tmux
tic tmux-256color.terminfo
tic xterm-256color-italic.terminfo

