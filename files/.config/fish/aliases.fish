# Dot aliases.
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias ...... "cd ../../../../.."

# Shorthand for ls
alias l 'ls -alhF'

# Let there be colors in cat!
alias cat ccat

# Sudo apt-get as it is always what you want.
alias apt-get "sudo apt-get"

# Python as Python3
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

# Apps
alias docker-daemon 'open --background -a Docker'
alias neo 'neofetch --block_range 0 15 --off'

# Git subcommands shortcuts.
abbr -a gc git commit
abbr -a gco git commit
abbr -a gcp git cherry-pick
abbr -a gd git diff
abbr -a gl git short
abbr -a gs git status
abbr -a ga git commit --amend

abbr -a "g[" git [
abbr -a "g]" git ]
abbr -a "g+" git +
abbr -a "g-" git--

# Autocomplete the tags and branches as commands. The git function lets you do
# that and having completion for it is pretty cool.
complete -f -c git -a '(__fish_git_branches)' --description 'Branch'
complete -f -c git -a '(__fish_git_tags)' --description 'Tag'

function vim
    command nvim -p $argv 2>/dev/null
end
