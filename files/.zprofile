# Set PATH, MANPATH, etc., for Homebrew.
if [[ -f "/opt/homebrew/bin/brew" ]] then
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Mise (rtx)
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "zed" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh --shims)"
else
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
