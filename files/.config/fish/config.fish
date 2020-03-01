. ~/.config/fish/aliases.fish

function nvm
    if functions -q bass
        if test -e brew
            bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
        # else
        end
    end
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

