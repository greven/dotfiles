# Set PATH, MANPATH, etc., for Homebrew.
if [[ -f "/opt/homebrew/bin/brew" ]] then
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Mise (rtx)
if [[ -o interactive ]] then
  eval "$($HOME/.local/bin/mise activate zsh)"
else
  eval "$($HOME/.local/bin/mise activate zsh --shims)"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Set Elixir mix deps compilation core count
MIX_OS_DEPS_COMPILE_PARTITION_COUNT=6
