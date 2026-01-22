# Dotfiles

My terminal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Uses [XDG Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory) standard for clean organization.

## What's Included

- **zsh** - Shell config (oh-my-zsh, vi mode, starship prompt)
- **tmux** - Tmux customizations (oh-my-tmux based)
- **tmux-bin** - Tmux scripts (sessionizer, scratchpad)
- **starship** - Prompt theme (gruvbox-rainbow)
- **nvim** - Neovim config (kickstart.nvim based)
- **tmux-sessionizer** - Config template for sessionizer paths

## Quick Start

```bash
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## XDG Directory Structure

```
~/.config/                              # XDG_CONFIG_HOME
├── tmux/
│   ├── tmux.conf        -> oh-my-tmux  # Framework (symlink)
│   └── tmux.conf.local  -> dotfiles    # Your customizations
├── nvim/                -> dotfiles    # Neovim config
├── starship.toml        -> dotfiles    # Prompt theme
└── tmux-sessionizer/                   # Sessionizer config

~/.local/
├── share/
│   └── oh-my-tmux/                     # oh-my-tmux repo
└── bin/
    ├── sessionizer                     # tmux project picker
    └── scratchpad                      # nvim popup
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

3. **Remove machine-specific paths** from `~/.zshrc` if not needed

## Key Bindings

| Binding | Action |
|---------|--------|
| `prefix + f` | tmux-sessionizer (project picker) |
| `prefix + n` | nvim scratchpad popup |
| `bindkey -v` | Vi mode in zsh |

## Manual Installation

```bash
# Install dependencies (Debian/Ubuntu)
sudo apt install -y zsh stow git fzf neovim tmux
curl -sS https://starship.rs/install.sh | sh

# Clone
git clone git@github.com:JSai23/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install oh-my-tmux (XDG style)
git clone --single-branch https://github.com/gpakosz/.tmux.git ~/.local/share/oh-my-tmux
mkdir -p ~/.config/tmux
ln -s ~/.local/share/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf

# Stow configs
stow zsh tmux starship nvim tmux-sessionizer

# Install scripts
cp tmux-bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

## Dependencies (Installed Separately)

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) - `~/.oh-my-zsh/`
- [oh-my-tmux](https://github.com/gpakosz/.tmux) - `~/.local/share/oh-my-tmux/`

## Fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) for icons.
Recommended: JetBrains Mono Nerd Font.

## Sources & Customizations

See [sources.md](sources.md) for:
- Where each config comes from (upstream templates)
- What customizations have been made
- How to update upstream dependencies
