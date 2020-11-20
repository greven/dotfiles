# Add .local bin to PATH
set PATH {$HOME}/.local/bin $PATH

# Elixir
set -x ERL_LIBS /usr/lib/elixir/lib

# MacOS
test -e {$HOME}/.iterm2_shell_integration.fish
and source {$HOME}/.iterm2_shell_integration.fish

## Aliases

# Shell
alias l 'ls -alhF'

# Python as Python3
alias python python3
alias pip pip3

# Scripts
alias wth 'git-what-the-hell-just-happened.sh'

# Apps
alias g git
alias docker-daemon 'open --background -a Docker'
alias neo 'neofetch --block_range 0 15 --off'
