if status is-interactive
    fish_config theme choose catppuccin-mocha
    # Initialize OhMyPosh
    oh-my-posh init fish --config ~/.config/omp/ompconfig.json | source
end
