# Important: needed because of such things like angular completion
[[ -n "$ZSH_VERSION" && $- == *i* ]] || return
autoload -Uz compinit
compinit

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
alias ff="fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%:wrap"

# Load Angular CLI autocompletion.
if command -v ng >/dev/null 2>&1; then
    source <(ng completion script)
fi

# Extras
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
eval "$(starship init zsh)"

## Commands for work prokects
# Run backend the same way it would start within Intellij
run() {
  if [ "$1" != "backend" ]; then
    echo "usage: run backend"; return 1
  fi

  # Enforce current dir is root of the project
case "$PWD" in
    *"/frontend"*|*"/backend"*)
      echo "run backend cli command only works within the root path"
      return 1
      ;;
    *) ;;
  esac

  (
    # Sanity checks
    [ -f pom.xml ]     || { echo "❌ '$DIR/pom.xml' not found - necessary for type-generator"; exit 1; }
    [ -f backend/pom.xml ]  || { echo "❌ '$DIR/backend/pom.xml' not found - necessary for starting the compiled backend"; exit 1; }

    echo "⚙️ 1/3 compile"
    mvn clean compile \
      || { echo "❌ compile failed"; exit 1; }

    echo "✨  2/3 type-generator"
    mvn -f pom.xml -N type-generator:type-generator \
      || { echo "❌ type-generator failed"; exit 1; }

    echo "🚀  3/3 start backend"
    mvn -f backend/pom.xml \
      -DskipTests \
      -Dspring-boot.run.main-class=ch.adibilis.BaseApplication \
      -Dspring-boot.run.jvmArguments="--enable-preview" \
      spring-boot:run \
      || { echo "❌ starting compiled backend failed"; exit 1; }
  )
}

