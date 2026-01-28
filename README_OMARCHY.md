# Install dotfiles for Omarchy

## Configure Omarchy

There are several things that has to be configured on a freshly installed Omarchy-System.\
Run the configuration script to ensure the most hard and annoying stuff will be\
done automatically:

```bash
cd dotfiles
./configure-omarchy.sh
```

## Install Requirements

### Stow

```bash
sudo pacman -S --needed stow
```

### Tmux

```bash
sudo pacman -S --needed tmux
```

### Ghostty

```bash
sudo pacman -S --needed ghostty
```

If pacman cannot find the package, then install the AUR:

```bash
git clone https://aur.archlinux.org/ghostty.git
cd ghostty
makepkg -si
```

### Zsh

```bash
sudo pacman -S --needed zsh
```

Make zsh the default:

```bash
chsh -s /bin/zsh
```

### Bat

```bash
sudo pacman -S --needed bat
```

### Angular CLI

```bash
sudo pacman -S --needed nodejs npm pnpm
```

```bash
npm add -g @angular/cli
```

Check the version to ensure it is installed properly:

```bash
ng version
```

## Stow files

```bash
git clone https://github.com/TheRaigeki/dotfiles.git
cd dotfiles
```

Then use GNU Stow to create symlinks.
**NEVER DO:**

```bash
stow .
```

This will tell stow to create symlinks from all top-level folders\
directly into $HOME, which will give you i.e. ~/nvim/.config/nvim/...

**CORRECT WAY:**

```bash
stow nvim
stow terminal
stow zsh
```

NOTE: If you ever want to remove a symlinks, use the -D flag like so:\
`stow -D nvim` in your dotfiles folder.

## Configurations

## Ghostty Terminal Error

If you come across this error when typing `clear` in the terminal while using the ghostty terminal:

**xterm-ghostty: unknown terminal type**

Then you need to add this to your .bashrc or .zshrc (whichever you use) to support the color schema ghostty uses:

```sh
if [ "$TERM" = "xterm-ghostty" ]; then
  export TERM=xterm-256color
fi
```

### Nvim

Grant Sudo Permissions for Nvim to prevent sudo conflicts

```bash
sudo chown -R $(whoami) ~/.local/share/nvim
sudo chown -R $(whoami) ~/.config/nvim
sudo chown -R $(whoami) ~/.cache/nvim
```

### Tmux

```bash
git clone https://github.com/tmux-plugins/tmp ~/.tmux/plugins/tmp
```

```bash
chmod -x ~/.tmux/plugins/tmp
```

After that all, start tmux and type PREFIX + I to install all packages.
Try PREFIX + o, if it does not open sessionx, try the following:

```bash
chmod +x ~/.config/tmux/plugins/tmux-sessionx/scripts/tmuxinator.sh
chmod +x ~/.config/tmux/plugins/tmux-sessionx/scripts/sessionx.sh
```

### Screen Sharing

To enable screen sharing on Omarchy, you need to install the desktop-portal\
like this:

```bash
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-hyprland
```

Then check, if the service is running properly:

```bash
systemctl --user status xdg-desktop-portal
systemctl --user status xdg-desktop-portal-hyprland
```

In case it is not running, start it:

```bash
systemctl --user enable --now xdg-desktop-portal
systemctl --user enable --now xdg-desktop-portal-hyprland
```

## ADDITIONAL MANUAL CONFIG CHANGES

A few files cannot be copied into dotfiles, since it can change when changing\
theme, font or enabling/disabling features like the fingerprint sensor.

Set `rounding = 20` in `~/.config/hypr/hyprlock.conf`.
