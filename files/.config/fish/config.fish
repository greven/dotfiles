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

# MacOS
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
