#!/bin/bash

# check if nvim is already installed
if which nvim >/dev/null 2>&1; then
    echo "Neovim is already installed."
    nvim --version
fi

# Install dependencies
echo "Installing dependencies for Neovim..."
sudo pacman -S --no-confirm --needed base-devel cmake ninja curl git

echo "Installing Neovim from source..."
mkdir -p $HOME/Github

cd $HOME/Github
if [ ! -d "neovim" ]; then
    git clone https://github.com/neovim/neovim.git
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi

echo "Setting up Neovim configuration..."
pacman -Sy --no-confirm --needed stow

if [ -d "$HOME/.config/nvim" ]; then
    mv $HOME/.config/nvim $HOME/.config/nvim.bak
    echo "Existing Neovim configuration backed up to $HOME/.config/nvim.bak"
fi

cd $HOME/dotfiles
stow -t $HOME/.config nvim

echo "Neovim installation completed."
nvim --version
