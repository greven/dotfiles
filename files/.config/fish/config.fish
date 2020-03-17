. ~/.config/fish/aliases.fish

# NodeJS nvm
function nvm
    if functions -q bass
        if test -e brew
            # MacOS
            bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
        else
            # Linux
            bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
        end
    end
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

# Add .local bin to PATH
set PATH {$HOME}/.local/bin $PATH

# Elixir
set -x ERL_LIBS /usr/lib/elixir/lib

# Linuxbrew
set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
set -gx HOMEBREW_CELLAR /home/linuxbrew/.linuxbrew/Cellar
set -gx HOMEBREW_REPOSITORY /home/linuxbrew/.linuxbrew/Homebrew
set -g fish_user_paths /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin $fish_user_paths
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /home/linuxbrew/.linuxbrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /home/linuxbrew/.linuxbrew/share/info $INFOPATH

# MacOS
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
