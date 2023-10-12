#!/bin/bash
set -e

# Install dependencies.
echo "Step (1/5): Installing Dependencies.."
sudo pacman -S vim neovim tmux neofetch alacritty zsh i3-wm i3status dmenu rofi ttf-jetbrains-mono-nerd npm xorg xorg-xinit xf86-video-intel xorg-server xclip wget firefox keepassxc unzip openssh htop

# Change default shell to zsh. 
echo "Step (2/5): Changing Default Shell to Zsh.."
chsh -s $(which zsh)

# Install oh-my-zsh, oh-my-posh, and desired plugins.
echo "Step (3/5): Installing Oh-My-Zsh, Oh-My-Posh, and Zsh Plugins.."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
curl -s https://ohmyposh.dev/install.sh | sudo bash -s
mkdir -p $HOME/.oh-my-posh/themes
curl https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/darkblood.omp.json -o $HOME/.oh-my-posh/themes/darkblood.omp.json

# Create ssh key, also for use with Github authentication.
echo "Step (4/5): Creating SSH Key.."
ssh-keygen -t ed25519 -C "blakethelawyer@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
echo "VisualHostKey yes" >> ~/.ssh/config

# Re-clone the repo with ssh, and configure git.
echo "Step (5/5): Cloning dotfiles repository.."
git clone git@github.com:blakelawyer/dotfiles.git
git config --global user.email "blakethelawyer@gmail.com"
git config --global user.name "Blake Lawyer"
