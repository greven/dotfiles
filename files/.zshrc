# Aliases
alias neo='neofetch --block_range 0 15 --off'

# Python Virtulenvwrapper
export WORKON_HOME=~/.envs

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Alias for NeoVim
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi
