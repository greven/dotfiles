function iterm2_print_user_vars
    echo "HELLO"
    set -l node_version (node -v)
    iterm2_set_user_var nodeVersion "$node_version"
end
