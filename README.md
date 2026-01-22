# Dotfiles

My terminal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **zsh** - Shell config (uses oh-my-zsh)
- **tmux** - Tmux customizations (uses oh-my-tmux)
- **tmux-bin** - Tmux scripts (sessionizer, scratchpad)
- **starship** - Prompt theme (gruvbox-rainbow)

## Quick Start

```bash
# Clone
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles

# Install
cd ~/dotfiles
./install.sh
```

## Manual Installation

If you prefer to install manually:

```bash
# Install dependencies (macOS)
brew install zsh stow git fzf starship

# Install dependencies (Debian/Ubuntu)
sudo apt install -y zsh stow git fzf
curl -sS https://starship.rs/install.sh | sh

# Clone and stow
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow zsh tmux starship

# Copy tmux scripts
mkdir -p ~/.tmux/bin
cp tmux-bin/* ~/.tmux/bin/
chmod +x ~/.tmux/bin/*
```

## Structure

```
~/dotfiles/
├── zsh/
│   └── .zshrc              -> ~/.zshrc
├── tmux/
│   └── .tmux.conf.local    -> ~/.tmux.conf.local
├── tmux-bin/
│   ├── sessionizer         -> ~/.tmux/bin/sessionizer
│   └── scratchpad          -> ~/.tmux/bin/scratchpad
├── starship/
│   └── .config/
│       └── starship.toml   -> ~/.config/starship.toml
├── install.sh
├── sources.md
└── README.md
```

## Dependencies (Installed Separately)

These are cloned/installed by `install.sh`, not tracked in this repo:

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) - `~/.oh-my-zsh/`
- [oh-my-tmux](https://github.com/gpakosz/.tmux) - `~/.tmux/`

## Fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) for icons to display correctly.
Recommended: JetBrains Mono Nerd Font.

## Updating

See [sources.md](sources.md) for how to update upstream dependencies.
