#!/bin/bash

# check if nvim is already installed
if which tmux >/dev/null 2>&1; then
    echo "Tmux is already installed."
    exit 0
fi

# Install dependencies
echo "Installing dependencies for Tmux..."
sudo pacman -S --no-confirm --needed tmux
echo "Tmux installation completed."
tmux -V

echo "Setting up Tmux configuration..."
pacman -Sy --no-confirm --needed stow
if [ -d "$HOME/.tmux" ]; then
    mv $HOME/.tmux $HOME/.tmux.bak
    echo "Existing Tmux configuration backed up to $HOME/.tmux.bak"
fi

cd $HOME/dotfiles
stow -t $HOME/.config tmux
echo "Tmux configuration setup completed."

echo "Setup Scritps for Tmux"
stow -t $HOME/.config scripts
