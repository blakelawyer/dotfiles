#!/bin/bash

# nvim
rm -rf "$HOME/.config/nvim"
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

# i3
rm -rf "$HOME/.config/i3"
ln -s "$HOME/dotfiles/i3" "$HOME/.config/i3"

# wezterm
rm -rf "$HOME/.config/wezterm"
ln -s "$HOME/dotfiles/wezterm" "$HOME/.config/wezterm"

# zsh
rm -rf "$HOME/.zshrc"
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"

# tmux
rm -rf "$HOME/.tmux.conf"
ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

# newsboat
rm -rf "$HOME/.newsboat"
ln -s "$HOME/dotfiles/.newsboat" "$HOME/.newsboat"

# X11
rm -rf "$HOME/.xinitrc"
ln -s "$HOME/dotfiles/.xinitrc" "$HOME/.xinitrc"
