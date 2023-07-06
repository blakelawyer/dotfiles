#!/bin/bash

# nvim
rm -rf "$HOME/.config/nvim"
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

# tmux
rm -rf "$HOME/.tmux.conf"
ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

# zsh
rm -rf "$HOME/.zshrc"
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"

# i3
rm -rf "$HOME/.config/i3"
ln -s "$HOME/dotfiles/.config/i3" "$HOME/.config/i3"

# alacritty
rm -rf "$HOME/.config/alacritty"
ln -s "$HOME/dotfiles/.config/alacritty" "$HOME/.config/alacritty"

# xinitrc
rm -rf "$HOME/.xinitrc"
ln -s "$HOME/dotfiles/.xinitrc" "$HOME/.xinitrc"

# Xmodmap
rm -rf "$HOME/.Xmodmap"
ln -s "$HOME/dotfiles/.Xmodmap" "$HOME/.Xmodmap"
