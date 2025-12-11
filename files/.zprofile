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

# Docker
export PATH=$HOME/.docker/bin:$PATH
fpath=(/Users/greven/.docker/completions $fpath)
autoload -Uz compinit
compinit

# Set Elixir mix deps compilation core count
MIX_OS_DEPS_COMPILE_PARTITION_COUNT=6

# Set PLUG_EDITOR to open files in VSCode from Elixir
export PLUG_EDITOR="vscode://file/__FILE__:__LINE__"

# opencode
export PATH=/Users/greven/.opencode/bin:$PATH
