# Add .local bin to PATH
set PATH {$HOME}/.local/bin $PATH

# Elixir bin
set -x ERL_LIBS /usr/lib/elixir/lib

# Don't show the greeting message on fish boot.
set -x fish_greeting ''

# Add color support for terminals pretending to be xterm.
test $TERM = xterm
and set -x TERM xterm-256color

# Make sure we have a unicode capable LANG and LC_CTYPE so the unicode
# characters does not look like crap on OSX and other environments.
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Don't let fish masquerade itself as other shells.
set -x SHELL (which fish)

# Help out programs spawning editors based on $EDITOR.
set -x EDITOR code
set -x PAGER less
set -x BROWSER open

# Source the aliases in ~/.config/fish/aliases.fish.
test -f ~/.config/fish/aliases.fish
and source ~/.config/fish/aliases.fish

# brew
set PATH /opt/homebrew/bin $PATH
set PATH /opt/homebrew/sbin $PATH

# asdf
source ~/.asdf/asdf.fish

# Source MacOS iTerm2 integration.
if test -f ~/.config/fish/iterm2.fish
    test -e ~/.iterm2_shell_integration.fish
    and source ~/.iterm2_shell_integration.fish
    or true
    source ~/.config/fish/iterm2.fish
end
