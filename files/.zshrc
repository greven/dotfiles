source $HOME/.exports
source $HOME/.profile

# Set Zinit (Plugin Manager) directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Source load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Oh My Posh (Prompt)
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/config.toml)"

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

# Zinit cache perf
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,underline"

## Shell integrations
eval "$(fzf --zsh)" # FZF
eval "$(zoxide init --cmd cd zsh)" # Zoxide

## History

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

## Keybindings

bindkey -e # Emacs keybinds
bindkey '^ ' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

## Aliases

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Clear Shorthand
alias c='clear'

# Replace ls with eza
alias ls='eza'
# List all files in long format
alias l='ls -lh --color'
# List all files in long format, excluding . and ..
alias la='ls -lAh --no-permissions --octal-permissions --color --git'

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Print each PATH entry on a separate line
alias path='echo -e $PATH\\n'

# Scripts
alias wth='git-what-the-hell-just-happened.sh'

# Git subcommands shortcuts
alias gc='git commit'
alias gs='git state'
alias gl='git graph'

# Apps
alias vim='nvim'
alias docker-daemon='open --background -a Docker'
alias neo='neofetch --block_range 0 15 --off'

# Dev
alias imix='iex -S mix'

# IP addresses
alias localip='ipconfig getifaddr en0'

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Utils
alias timestamp='date -u "+%Y%m%d%H%M%S"'
alias week='date +%V'

# MacOS specific settings

if [ Darwin = `uname` ]; then
  # ... MacOS settings
fi
