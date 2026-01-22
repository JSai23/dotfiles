# Cleanup Guide

Manual cleanup steps for migrating from old dotfiles setup.

## Before Running install.sh

If you have existing configs, back them up or remove them first.

### Old oh-my-zsh location
```bash
# Check if exists
ls -la ~/.oh-my-zsh

# Remove (new location is ~/.local/share/oh-my-zsh)
rm -rf ~/.oh-my-zsh
```

### Old tmux configs
```bash
# Old symlink
rm ~/.tmux.conf

# Old local config (backup first if you have customizations)
mv ~/.tmux.conf.local ~/.tmux.conf.local.old

# Old oh-my-tmux location
rm -rf ~/.tmux
```

### Existing configs that stow will conflict with
```bash
# zshrc
mv ~/.zshrc ~/.zshrc.old

# starship
mv ~/.config/starship.toml ~/.config/starship.toml.old

# nvim
mv ~/.config/nvim ~/.config/nvim.old

# tmux
mv ~/.config/tmux/tmux.conf.local ~/.config/tmux/tmux.conf.local.old
```

## After Verifying New Setup Works

Once you've confirmed everything works, you can remove the old backups:

```bash
rm ~/.zshrc.old
rm ~/.tmux.conf.local.old
rm -rf ~/.config/nvim.old
rm ~/.config/starship.toml.old
rm ~/.config/tmux/tmux.conf.local.old
```
