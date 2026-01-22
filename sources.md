# Sources & Dependencies

This document tracks where each configuration comes from and what customizations have been made.

---

## Upstream Dependencies (cloned/installed by install.sh)

| Tool | Source | Purpose |
|------|--------|---------|
| oh-my-zsh | https://github.com/ohmyzsh/ohmyzsh | Zsh framework |
| oh-my-tmux | https://github.com/gpakosz/.tmux | Tmux configuration framework |
| starship | https://starship.rs | Cross-shell prompt |
| zsh-syntax-highlighting | https://github.com/zsh-users/zsh-syntax-highlighting | Fish-like syntax highlighting |
| zsh-autosuggestions | https://github.com/zsh-users/zsh-autosuggestions | Fish-like autosuggestions |
| kickstart.nvim | https://github.com/nvim-lua/kickstart.nvim | Neovim starter config |

---

## Config Files: Upstream vs Custom

### zsh/.zshrc

**Template:** oh-my-zsh default `.zshrc`

**Custom Changes:**
- `TERM=xterm-256color` / `COLORTERM=truecolor` - True color support
- `ZSH_THEME="eastwood"` - Theme selection
- `plugins=(git zsh-syntax-highlighting zsh-autosuggestions)` - Plugin list
- `EDITOR='nvim'` / `VISUAL='nvim'` - Default editor
- `eval "$(starship init zsh)"` - Starship prompt
- `bindkey -v` - **Vi mode enabled**
- Claude Code, bun, cargo PATH additions (machine-specific, may need adjustment)

---

### tmux/.tmux.conf.local

**Template:** [oh-my-tmux .tmux.conf.local](https://github.com/gpakosz/.tmux/blob/master/.tmux.conf.local)

**Custom Changes (lines 413-519):**
- `prefix + f` → tmux-sessionizer (line 414)
- `prefix + n` → nvim scratchpad popup (line 417)
- `default-shell /usr/bin/zsh` (lines 517-519)

Everything else is oh-my-tmux defaults with minor theme tweaks.

---

### tmux-bin/sessionizer

**Template:** [ThePrimeagen/tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer)

**Custom Changes:**
- Uses config file at `~/.config/tmux-sessionizer/tmux-sessionizer.conf`
- Default search paths: `~/ ~/personal ~/personal/dev/env/.config`
- **Configure per-machine:** Copy `tmux-sessionizer.conf.example` to `tmux-sessionizer.conf`

---

### tmux-bin/scratchpad

**Template:** None (custom script)

Opens nvim in a persistent tmux session for quick notes.

---

### starship/.config/starship.toml

**Template:** [gruvbox-rainbow preset](https://starship.rs/presets/gruvbox-rainbow)

**Custom Changes:** None (stock preset)

---

### nvim/.config/nvim/

**Template:** [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

**Custom Changes in init.lua:**
- Line 94: `vim.g.have_nerd_font = false` (set to true if using Nerd Font)
- Line 884-898: tokyonight colorscheme with italics disabled
- Line 946-949: treesitter parsers list (added python, json)
- Line 972: neo-tree plugin enabled

**Plugins (via lazy.nvim):**
- guess-indent.nvim
- gitsigns.nvim
- which-key.nvim
- telescope.nvim + extensions
- lazydev.nvim
- nvim-lspconfig + mason
- conform.nvim (autoformat)
- blink.cmp (completion)
- tokyonight.nvim (colorscheme)
- todo-comments.nvim
- mini.nvim (ai, surround, statusline)
- nvim-treesitter
- neo-tree.nvim (file explorer)

---

### tmux-sessionizer/.config/tmux-sessionizer/

**Template:** N/A

Contains `tmux-sessionizer.conf.example` - copy and customize for each machine.

---

## Fonts Required

For starship, nvim icons, and tmux to display correctly:
- **Recommended:** [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)
- Set `vim.g.have_nerd_font = true` in nvim/init.lua after installing

---

## Updating Upstream Tools

| Tool | Command |
|------|---------|
| oh-my-zsh | `omz update` |
| oh-my-tmux | `cd ~/.tmux && git pull` |
| starship | `curl -sS https://starship.rs/install.sh \| sh` |
| zsh plugins | `git -C ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting pull` |
| kickstart.nvim | Check repo for updates, manually merge into init.lua |
| nvim plugins | `:Lazy update` in nvim |
| tmux-sessionizer | Check [repo](https://github.com/ThePrimeagen/tmux-sessionizer), update `tmux-bin/sessionizer` |

---

## Machine-Specific Config

These need adjustment per machine:

1. **zshrc:** PATH entries for Claude Code, bun, cargo (remove if not installed)
2. **tmux-sessionizer:** Create `~/.config/tmux-sessionizer/tmux-sessionizer.conf` with your project paths
3. **nvim:** Set `vim.g.have_nerd_font = true` if using Nerd Fonts
