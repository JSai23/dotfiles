# Dotfiles

My terminal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Included

- **zsh** - Shell config (oh-my-zsh, vi mode, starship prompt)
- **tmux** - Tmux customizations (oh-my-tmux based)
- **tmux-bin** - Tmux scripts (sessionizer, scratchpad)
- **starship** - Prompt theme (gruvbox-rainbow)
- **nvim** - Neovim config (kickstart.nvim based)
- **tmux-sessionizer** - Config template for sessionizer paths

## Quick Start

```bash
# Clone
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles

# Install
cd ~/dotfiles
./install.sh
```

## Post-Install Setup

1. **Configure sessionizer paths** (per-machine):
   ```bash
   cp ~/.config/tmux-sessionizer/tmux-sessionizer.conf.example \
      ~/.config/tmux-sessionizer/tmux-sessionizer.conf
   # Edit to add your project directories
   ```

2. **If using Nerd Fonts**, edit `~/.config/nvim/init.lua`:
   ```lua
   vim.g.have_nerd_font = true
   ```

3. **Remove machine-specific paths** from `~/.zshrc` if not needed:
   - Claude Code paths
   - bun paths
   - cargo paths

## Key Bindings

| Binding | Action |
|---------|--------|
| `prefix + f` | Open tmux-sessionizer (project picker) |
| `prefix + n` | Open nvim scratchpad popup |
| `bindkey -v` | Vi mode in zsh |

## Manual Installation

```bash
# Install dependencies (macOS)
brew install zsh stow git fzf starship neovim tmux

# Install dependencies (Debian/Ubuntu)
sudo apt install -y zsh stow git fzf neovim tmux
curl -sS https://starship.rs/install.sh | sh

# Clone and stow
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow zsh tmux starship nvim tmux-sessionizer

# Copy tmux scripts
mkdir -p ~/.tmux/bin
cp tmux-bin/* ~/.tmux/bin/
chmod +x ~/.tmux/bin/*
```

## Structure

```
~/dotfiles/
├── zsh/
│   └── .zshrc                    -> ~/.zshrc
├── tmux/
│   └── .tmux.conf.local          -> ~/.tmux.conf.local
├── tmux-bin/
│   ├── sessionizer               -> ~/.tmux/bin/sessionizer
│   └── scratchpad                -> ~/.tmux/bin/scratchpad
├── starship/
│   └── .config/
│       └── starship.toml         -> ~/.config/starship.toml
├── nvim/
│   └── .config/
│       └── nvim/
│           ├── init.lua          -> ~/.config/nvim/init.lua
│           └── lua/...           -> ~/.config/nvim/lua/...
├── tmux-sessionizer/
│   └── .config/
│       └── tmux-sessionizer/
│           └── *.conf.example    -> ~/.config/tmux-sessionizer/
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

## Sources & Customizations

See [sources.md](sources.md) for detailed documentation of:
- Where each config comes from (upstream templates)
- What customizations have been made
- How to update upstream dependencies
