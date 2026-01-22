#!/bin/bash
set -e

echo "Installing dotfiles..."

# Detect OS and install dependencies
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install zsh stow git fzf starship
elif [[ -f /etc/debian_version ]]; then
    echo "Detected Debian/Ubuntu"
    sudo apt update
    sudo apt install -y zsh stow git fzf
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Unknown OS. Please install manually: zsh stow git fzf starship"
    exit 1
fi

# Install oh-my-zsh (if not present)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install oh-my-tmux (if not present)
if [ ! -d "$HOME/.tmux" ]; then
    echo "Installing oh-my-tmux..."
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
fi

# Backup existing configs if they're not symlinks
backup_if_exists() {
    if [ -f "$1" ] && [ ! -L "$1" ]; then
        echo "Backing up $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

backup_if_exists ~/.zshrc
backup_if_exists ~/.tmux.conf.local
backup_if_exists ~/.config/starship.toml

# Ensure .config exists
mkdir -p ~/.config

# Stow configs
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "Stowing configs..."
stow -v zsh
stow -v tmux
stow -v starship

# Copy tmux bin scripts (can't stow these easily into oh-my-tmux structure)
echo "Installing tmux scripts..."
mkdir -p ~/.tmux/bin
cp tmux-bin/* ~/.tmux/bin/
chmod +x ~/.tmux/bin/*

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

echo ""
echo "Done! Restart your shell or run: exec zsh"
echo ""
echo "Note: For the best experience, install a Nerd Font:"
echo "  https://www.nerdfonts.com/font-downloads (JetBrains Mono recommended)"
