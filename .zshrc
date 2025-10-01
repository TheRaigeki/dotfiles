# Detect OS
case "$(uname -s)" in
  Darwin)   # macOS
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    export JAVA_HOME=$(/usr/libexec/java_home)
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PNPM_HOME="$HOME/Library/pnpm"
    ;;
  Linux)
    export JAVA_HOME=/usr/lib/jvm/default
    export ANDROID_HOME=$HOME/Android/Sdk
    export PNPM_HOME="$HOME/.local/share/pnpm"
    ;;
esac

# Shared PATHs (work on both)
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/.config/tmux/scripts:$PATH"
export PATH="/opt/apache-maven/bin:$PATH"

# Aliases
alias lg='lazygit'
alias vim='nvim'
alias ls='eza -lh --group-directories-first --icons=auto'

# Extras
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(starship init zsh)"
