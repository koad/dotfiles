# Dotfiles

Personal configuration files managed via symbolic links.

## Setup

1. Clone this repository to `~/.dotfiles`:
    ```bash
    git clone git@github.com:koad/dotfiles.git ~/.dotfiles
    ```

2. Create symlinks for each config file:
    ```bash
    ln -s ~/.dotfiles/.bashrc ~/.bashrc
    ln -s ~/.dotfiles/.ssh_aliases ~/.ssh_aliases
    ```

## Cairo-Dock Setup

```bash
ln -s ~/.dotfiles/dock/theme ~/.config/cairo-dock/current_theme
./dock/install.sh
```

## Keybinds Setup

```bash
./keybinds/install.sh
```

---

*Last updated: March 12, 2026*