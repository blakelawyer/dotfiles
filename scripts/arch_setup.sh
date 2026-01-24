#!/bin/bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${RED}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Step 1: Install dependencies
log "Step (1/5): Installing Dependencies..."
PACKAGES=(
    vim neovim tmux fastfetch alacritty zsh
    i3-wm i3status dmenu rofi bumblebee-status
    ttf-jetbrains-mono-nerd
    npm xterm xorg xorg-xinit xf86-video-intel xclip
    wget firefox keepassxc unzip openssh htop vlc git base-devel
    ripgrep fd zathura zathura-pdf-mupdf texlive-most python-pip
)
FAILED_PACKAGES=()
for pkg in "${PACKAGES[@]}"; do
    if ! sudo pacman -S --needed --noconfirm "$pkg" 2>/dev/null; then
        warn "Failed to install: $pkg"
        FAILED_PACKAGES+=("$pkg")
    fi
done
if [[ ${#FAILED_PACKAGES[@]} -gt 0 ]]; then
    warn "The following packages failed to install: ${FAILED_PACKAGES[*]}"
fi

# Install neovim-remote for LaTeX synctex support
pip install --user --break-system-packages neovim-remote

# Step 2: Change default shell to zsh
log "Step (2/5): Changing Default Shell to Zsh..."
if [[ "$SHELL" != *"zsh"* ]]; then
    chsh -s "$(which zsh)"
fi

# Step 3: Install oh-my-zsh, oh-my-posh, and plugins
log "Step (3/5): Installing Oh-My-Zsh, Oh-My-Posh, and Zsh Plugins..."

# Install oh-my-zsh NON-INTERACTIVELY (RUNZSH=no prevents shell switch)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Install oh-my-posh
curl -s https://ohmyposh.dev/install.sh | sudo bash -s
mkdir -p "$HOME/.oh-my-posh/themes"
curl -fsSL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/darkblood.omp.json \
    -o "$HOME/.oh-my-posh/themes/darkblood.omp.json"

# Step 4: Create SSH key
log "Step (4/5): Creating SSH Key..."
SSH_KEY="$HOME/.ssh/id_ed25519"
if [[ ! -f "$SSH_KEY" ]]; then
    ssh-keygen -t ed25519 -C "blakethelawyer@gmail.com" -f "$SSH_KEY" -N ""
fi
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"
xclip -selection clipboard < "${SSH_KEY}.pub"
log "SSH public key copied to clipboard!"

# Add VisualHostKey to ssh config (idempotent)
mkdir -p "$HOME/.ssh"
if ! grep -q "VisualHostKey yes" "$HOME/.ssh/config" 2>/dev/null; then
    echo "VisualHostKey yes" >> "$HOME/.ssh/config"
fi

# Step 5: Clone dotfiles and configure git
log "Step (5/5): Cloning dotfiles repository..."
git config --global user.email "blakethelawyer@gmail.com"
git config --global user.name "Blake Lawyer"

DOTFILES_DIR="$HOME/dotfiles"
if [[ ! -d "$DOTFILES_DIR" ]]; then
    git clone git@github.com:blakelawyer/dotfiles.git "$DOTFILES_DIR"
else
    log "Dotfiles directory already exists, skipping clone"
fi

# Run dotfiles install script to create symlinks
if [[ -f "$DOTFILES_DIR/install.sh" ]]; then
    bash "$DOTFILES_DIR/install.sh"
fi

# Clone journal repository
JOURNAL_DIR="$HOME/journal"
if [[ ! -d "$JOURNAL_DIR" ]]; then
    git clone git@github.com:blakelawyer/journal.git "$JOURNAL_DIR"
else
    log "Journal directory already exists, skipping clone"
fi

log "Setup complete! Please log out and back in for shell changes to take effect."
