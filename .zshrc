# Base-Path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Path to my oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Homebrew-Paths
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Export Java and Android-SDK for Android Development
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$PATH:/Library/Android/sdk/platform-tools"

#Maven
export PATH=/opt/apache-maven/bin:$PATH

# OpenJDK 17
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Initialize oh-my-posh after PATH is set
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokyonight_storm.omp.json)"
fi

# Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration
export LANG=en_US.UTF-8
alias lg='lazygit'
alias vim='nvim'

# Load Angular CLI autocompletion.
source <(ng completion script)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
