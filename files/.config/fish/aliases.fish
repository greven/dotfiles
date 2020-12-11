# Dot aliases.
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias ...... "cd ../../../../.."

# Shorthand for ls.
alias l 'ls -alhF'

# Sudo apt-get as it is always what you want.
alias apt-get "sudo apt-get"

# Python as Python3.
alias python python3
alias pip pip3

# Scripts
alias wth 'git-what-the-hell-just-happened.sh'

# Shortcuts for common executables.
abbr -a r rails
abbr -a m make
abbr -a d docker
abbr -a g git
abbr -a h heroku

# Apps.
alias neo 'neofetch --block_range 0 15 --off'
alias docker-daemon 'open --background -a Docker'

# Git subcommands shortcuts.
abbr -a gc git commit
abbr -a gco git commit
abbr -a gaa git aa
abbr -a gcp git cherry-pick
abbr -a gd git diff
abbr -a gl git graph
abbr -a gs git state
abbr -a ga git commit --amend

# Autocomplete the tags and branches as commands.
complete -f -c git -a '(__fish_git_branches)' --description 'Branch'
complete -f -c git -a '(__fish_git_tags)' --description 'Tag'

function vim
    command nvim -p $argv 2>/dev/null
end
