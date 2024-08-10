# Set up PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$PATH/Library/Android/sdk/platform-tools"

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Initialize oh-my-posh after PATH is set
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokyonight_storm.omp.json)"
fi

# User configuration
export LANG=en_US.UTF-8
alias lg='lazygit'
alias vim='nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Export Java and Android-SDK for Android Development
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Load Angular CLI autocompletion.
source <(ng completion script)
