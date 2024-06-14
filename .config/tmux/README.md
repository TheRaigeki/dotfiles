# My personal tmux configuration

## ATTENTION

Before pull this repo, make sure you installed tmux.

## Additional Plugins

You also need to install additional packages before pulling this repo to make sure everything works properly.

### tpm (tmux plugin manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### fzf-tmux (using Homebrew)

```
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

### bat (using Homebrew)

```
brew install bat
```

# Clone Repo and Install Plugins

Now you can clone this repo:
`git clone https://github.com/RobinRuf/tmux.git`

After that, open TMUX in your terminal and use PREFIX + I (CTRL+a + I) to install all plugins within the tmux.conf file automatically
