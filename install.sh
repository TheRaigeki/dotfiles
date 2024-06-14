#!/bin/bash

# Set the current directory as the dotfiles directory
DOTFILES_DIR=$(pwd)

# Function to create symbolic links
create_symlink() {
    local target=$1
    local link=$2

    # Remove existing file or symlink
    if [ -e "$link" ] || [ -L "$link" ]; then
        rm -rf "$link"
    fi

    # Create the symbolic link
    ln -s "$target" "$link"
    echo "Created symlink: $link -> $target"
}

# Create symbolic links
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
create_symlink "$DOTFILES_DIR/.config/raycast" "$HOME/.config/raycast"
create_symlink "$DOTFILES_DIR/.config/ohmyposh" "$HOME/.config/ohmyposh"
create_symlink "$DOTFILES_DIR/.git" "$HOME/.git"
create_symlink "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "All symbolic links have been created."
