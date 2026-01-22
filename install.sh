#!/bin/bash
set -e

echo "Installing dotfiles..."

# Set XDG defaults if not defined
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Detect OS and install dependencies
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install zsh stow git fzf starship neovim tmux
elif [[ -f /etc/debian_version ]]; then
    echo "Detected Debian/Ubuntu"
    sudo apt update
    sudo apt install -y zsh stow git fzf neovim tmux
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Unknown OS. Please install manually: zsh stow git fzf starship neovim tmux"
    exit 1
fi

# Install oh-my-zsh to XDG location (if not present)
OH_MY_ZSH_DIR="$XDG_DATA_HOME/oh-my-zsh"
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
    echo "Installing oh-my-zsh to $OH_MY_ZSH_DIR..."
    ZSH="$OH_MY_ZSH_DIR" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Install oh-my-tmux using XDG approach
OH_MY_TMUX_DIR="$XDG_DATA_HOME/oh-my-tmux"
if [ ! -d "$OH_MY_TMUX_DIR" ]; then
    echo "Installing oh-my-tmux to $OH_MY_TMUX_DIR..."
    git clone --single-branch https://github.com/gpakosz/.tmux.git "$OH_MY_TMUX_DIR"
fi

# Create XDG tmux config directory and symlink framework
mkdir -p "$XDG_CONFIG_HOME/tmux"
if [ ! -L "$XDG_CONFIG_HOME/tmux/tmux.conf" ]; then
    echo "Linking oh-my-tmux framework..."
    ln -sf "$OH_MY_TMUX_DIR/.tmux.conf" "$XDG_CONFIG_HOME/tmux/tmux.conf"
fi

# Ensure directories exist
mkdir -p "$XDG_CONFIG_HOME/tmux-sessionizer"
mkdir -p "$HOME/.local/bin"

# Stow configs
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "Stowing configs..."
stow -R -v zsh
stow -R -v tmux
stow -R -v starship
stow -R -v nvim

# Copy tmux-sessionizer example config if no local config exists
if [ ! -f "$XDG_CONFIG_HOME/tmux-sessionizer/tmux-sessionizer.conf" ]; then
    echo "Creating tmux-sessionizer config from example..."
    cp tmux-sessionizer/tmux-sessionizer.conf.example "$XDG_CONFIG_HOME/tmux-sessionizer/tmux-sessionizer.conf"
    echo "IMPORTANT: Edit $XDG_CONFIG_HOME/tmux-sessionizer/tmux-sessionizer.conf with your paths!"
fi

# Install tmux scripts to ~/.local/bin (XDG standard for user executables)
echo "Installing tmux scripts to ~/.local/bin..."
cp tmux-bin/* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/sessionizer" "$HOME/.local/bin/scratchpad"

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "Config locations (XDG style):"
echo "  oh-my-zsh:   $OH_MY_ZSH_DIR"
echo "  oh-my-tmux:  $OH_MY_TMUX_DIR"
echo "  tmux config: $XDG_CONFIG_HOME/tmux/"
echo "  nvim config: $XDG_CONFIG_HOME/nvim/"
echo "  scripts:     ~/.local/bin/"
echo ""
echo "Post-install steps:"
echo ""
echo "1. Edit tmux-sessionizer paths in $XDG_CONFIG_HOME/tmux-sessionizer/tmux-sessionizer.conf"
echo ""
echo "2. If using Nerd Fonts, edit $XDG_CONFIG_HOME/nvim/init.lua:"
echo "   vim.g.have_nerd_font = true"
echo ""
echo "3. Install a Nerd Font for best experience:"
echo "   https://www.nerdfonts.com/font-downloads (JetBrains Mono recommended)"
echo ""
echo "Restart your shell or run: exec zsh"
