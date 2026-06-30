function fzf-change-dirstack
    set --local ldir $(dirh | tail -n +2 | fzf --height="20%" --header="current: $(pwd)" | cut -f 1)
    cd -- "+$ldir" >/dev/null
    set -e ldir
end
