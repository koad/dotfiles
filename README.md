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

## Structure

- `.bashrc` - Bash shell configuration

## Adding New Dotfiles

To add a new config file:
1. Move the file to `~/.dotfiles/`
2. Create a symlink: `ln -s ~/.dotfiles/<filename> ~/<filename`

## Updating

Changes made to the symlinked files in `$HOME` will be reflected in the actual files in `~/.dotfiles`. Simply commit and push as usual.
