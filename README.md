# My Dotfiles

This Repo contains my dotfiles like my nvim setup, tmux configs and more.

## Requirements
Make sure you have the following installed on your systen

### Git
```
brew install git
```

### Stow
```
brew install stow
```

## Installation
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

## YouTube-Video
If you need more instructions, please visit this [YouTube Video](https://www.youtube.com/watch?v=y6XCebnB9gs).

### Other way (w/o stow)
You can also use the install.sh script to create the syslinks.\
For this, please run the following command in ./dotfiles: `chmod +x install.sh`\
After that, run the script like this: `./install.sh`

