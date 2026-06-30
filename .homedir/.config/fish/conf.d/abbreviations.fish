# .. abbr --addes
abbr --add dotdot --regex '^\.\.+$' --function multicd

# ls/eza abbr --addes
abbr --add l "eza"
abbr --add ll "eza -lah --git --icons=always --colour-scale=size"
abbr --add lll "eza -lah --git --icons=always --colour-scale=size --time-style=long-iso"
abbr --add la "eza -ah"
abbr --add lD "eza -lh --only-dirs"
abbr --add lDD "eza -lah --only-dirs"
abbr --add lF "eza -lh --only-files"
abbr --add lFF "eza -lah --only-files"
abbr --add lt "eza -Th --level=2"
abbr --add ltt "eza -Tha --level=2"

# yazi
abbr --add y --function "yazicdonquit"

# bat
abbr --add cat "bat"
abbr --add grep "batgrep --smart-case" # Colorful Grep with sane defaults

# WSL2/Windows
abbr --add reveal "explorer.exe ." # Reveal current dir in File explorer
abbr --add shutdown "wsl.exe --shutdown"
abbr --add terminate "wsl.exe --terminate archlinux"

# configs
abbr --add histedit "nvim ~/.local/share/fish/fish_history"

# make
abbr --add remake "make clean && make"

# count files
abbr --add count "find . -type f | wc -l"

# list files/dir by size
abbr --add dust "du -sh * | sort -hr"

# rsync abbr --addes
abbr --add rsync-copy "rsync -avz --progress -h"
abbr --add rsync-move "rsync -avz --progress -h --delete-source-files"
abbr --add rsync-update "rsync -avzu --progress -h"
abbr --add rsync-update "rsync -avzu --delete --progress -h"

# Git
abbr --add gis "git status"
abbr --add gss "git status -s"
abbr --add gid "git diff"
abbr --add gilg "git lg"
abbr --add glog "git log"
abbr --add gsub "git submodule update --remote --rebase"

# vim
abbr --add vim nvim
abbr --add vi nvim

# texlive
abbr --add updatetl "tlmgr update --self --all --reinstall-forcibly-removed"

# File manipulation
abbr --add rm "rm -iv"
abbr --add cp "cp -iv"
abbr --add mv "mv -iv"

# Global abbr --addes
abbr --add NE "2>/dev/null" # Send [N]ull [E]rror to /dev/null
abbr --add DN ">/dev/null" # Send standard output to /dev/null
abbr --add NUL ">/dev/null 2>&1" # Send all output to /dev/null
abbr --add C "| tee >(win32yank.exe -i)" # [Copy] output of command
abbr --add L "| bat" # Pipe output to [L]ess pager with bat coloring

# misc
abbr --add lg "lazygit"
abbr --add bcd "builtin cd"
abbr --add pse "zsh ~/minfiles/scripts/pse.zsh"
