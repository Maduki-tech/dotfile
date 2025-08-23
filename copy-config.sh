#!/bin/bash
# save as ~/copy-configs.sh

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# List of applications you want to manage
apps=("nvim" "ghostty" "hypr" "tmux" "zsh" "wofi" "waybar" " script")

for app in "${apps[@]}"; do
    if [ -d "$CONFIG_DIR/$app" ]; then
        echo "Processing $app..."
        
        # Create the stow package structure
        mkdir -p "$DOTFILES_DIR/$app/.config"
        
        # Copy the config
        cp -r "$CONFIG_DIR/$app" "$DOTFILES_DIR/$app/.config/"
        
        echo "$app copied to dotfiles"
    else
        echo "$app config not found, skipping..."
    fi
done
