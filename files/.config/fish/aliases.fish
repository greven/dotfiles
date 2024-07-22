# Dot aliases.
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias ...... "cd ../../../../.."

# Directory shortcuts.
alias dl "cd ~/Downloads"
alias dt "cd ~/Desktop"

# Shortcuts for common executables.
abbr -a g git
abbr -a m make
abbr -a d docker

# Replace `ls` with `exa`.
alias ls eza

# List all files in long format.
alias l 'ls -lh'

# List all files in long format, excluding . and ..
alias la 'ls -lAh'

# Always enable colored `grep` output.
alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# Sudo apt-get as it is always what you want.
alias apt-get "sudo apt-get"

# Python as Python3.
alias python python3
alias pip pip3

# Scripts
alias wth 'git-what-the-hell-just-happened.sh'

# Apps.
alias neo 'neofetch --block_range 0 15 --off'
alias docker-daemon 'open --background -a Docker'

# Print each PATH entry on a separate line.
alias path 'echo -e $PATH\\n'

# Utils.
alias timestamp 'date -u "+%Y%m%d%H%M%S"'
alias week='date +%V'

# Git subcommands shortcuts.
abbr -a gc git commit
abbr -a gco git commit
abbr -a gaa git aa
abbr -a gcp git cherry-pick
abbr -a gd git diff
abbr -a gl git graph
abbr -a gs git state
abbr -a gp git push
abbr -a ga git commit --amend

# IP addresses.
alias localip "ipconfig getifaddr en0"
alias ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces.
alias ifactive "ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Autocomplete the tags and branches as commands.
complete -f -c git -a '(__fish_git_branches)' --description Branch
complete -f -c git -a '(__fish_git_tags)' --description Tag

function vim
    command nvim -p $argv 2>/dev/null
end
