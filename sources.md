# Sources & Dependencies

## Tools (cloned/installed by install.sh)

| Tool | Source | Purpose |
|------|--------|---------|
| oh-my-zsh | https://github.com/ohmyzsh/ohmyzsh | Zsh framework |
| oh-my-tmux | https://github.com/gpakosz/.tmux | Tmux configuration framework |
| starship | https://starship.rs | Cross-shell prompt |
| zsh-syntax-highlighting | https://github.com/zsh-users/zsh-syntax-highlighting | Fish-like syntax highlighting |
| zsh-autosuggestions | https://github.com/zsh-users/zsh-autosuggestions | Fish-like autosuggestions |

## Configs

| File | Based On |
|------|----------|
| `starship/.config/starship.toml` | [gruvbox-rainbow preset](https://starship.rs/presets/gruvbox-rainbow) |
| `tmux-bin/sessionizer` | [ThePrimeagen/tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer) |
| `tmux-bin/scratchpad` | Custom script |

## Fonts Required

For the starship prompt and tmux to display correctly, install a Nerd Font:
- **Recommended:** [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)

## Updating Upstream Tools

| Tool | Command |
|------|---------|
| oh-my-zsh | `omz update` |
| oh-my-tmux | `cd ~/.tmux && git pull` |
| starship | `curl -sS https://starship.rs/install.sh \| sh` |
| zsh plugins | `git -C ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting pull` |
