# Set PATH, MANPATH, etc., for Homebrew.
if [[ -f "/opt/homebrew/bin/brew" ]] then
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="~/.rtx/shims:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
