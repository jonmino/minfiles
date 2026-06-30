# Package functions
function remove # List installed packages
    pacman -Qq | fzf --multi --reverse --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -R
end

function aurremove
    yay -Qq | fzf --multi --reverse --preview 'yay -Qi {1}' | xargs -ro yay -R
end

function install # Search for packages
    pacman -Slq | fzf --multi --reverse --preview 'pacman -Si {1}' | xargs -ro sudo pacman -Sy
end

function aurinstall
    yay -Slq | fzf --multi --reverse --preview 'yay -Si {1}' | xargs -ro yay -Sy
end
