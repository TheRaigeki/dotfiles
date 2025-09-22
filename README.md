# My Dotfiles

This Repo contains my dotfiles like my nvim setup, tmux configs and more.

## Requirements
Make sure you have the following installed on your system

### oh-my-zsh & starship
```
zsh --version
oh-my-posh --version
```
if not installed yet, install it:
```
brew install zsh
brew install starship
```

### Git
```
brew install git
```

### Stow
```
brew install stow
```

### ripgreg

```
brew install ripgreg
```

# Additional Configurations (DO BEFORE STOW)
## Nerd Font (wezterm)
To use Wezterm properly, you need to install the JetBrainsMono Nerd Font. You can do this with the following command: 
```
brew install font-jetbrains-mono-nerd-font
```

## Install Angular CLI

```
npm i -g @angular/cli
```

## NeoVim

```
brew install neovim
```
Grant Sudo Permissions for Nvim to prevent sudo conflicts

```
sudo chown -R $(whoami) ~/.local/share/nvim
sudo chown -R $(whoami) ~/.config/nvim
sudo chown -R $(whoami) ~/.cache/nvim
```
## Tmux

```
brew install tmux
```

```
git clone https://github.com/tmux-plugins/tmp ~/.tmux/plugins/tmp
```

```
brew install fzf
```

```
chmod -x ~/.tmux/plugins/tmp
```

## Link to Machine
Clone the repo to your $HOME-Directory,
```
git clone https://github.com/RobinRuf/dotfiles.git
cd dotfiles
```
Then use GNU Stow to create symlinks.
```
stow .
```

This will create references in the equivalent directories in your $Homne-Directory like in the dotfiles directory.

NOTE: If you ever want to remove all symlinks, use the -D flag like so: `stow -D .` in your dotfiles folder.

## Final Checks & Configurations

## Tmux
After that all, start tmux and type PREFIX + I to install all packages.
Try PREFIX + o, if it does not open sessionx, try the following:

```
chmod +x ~/.config/tmux/plugins/tmux-sessionx/scripts/tmuxinator.sh
chmod +x ~/.config/tmux/plugins/tmux-sessionx/scripts/sessionx.sh
```
