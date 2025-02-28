local titleParser = {} -- my "table" stdlib
local wezterm = require("wezterm")

local LAZYGIT = wezterm.nerdfonts.dev_git .. " Lazygit"
local GIT = wezterm.nerdfonts.dev_git .. " Git"
local MAKE = wezterm.nerdfonts.seti_makefile .. " Make"
local YAZI = wezterm.nerdfonts.md_folder .. " Yazi"

local get_title = {
    ["nvim"] = wezterm.nerdfonts.custom_vim .. " Nvim",
    ["make"] = MAKE,
    ["remake"] = MAKE,
    ["vim"] = wezterm.nerdfonts.dev_vim .. " Vim",
    ["zsh"] = wezterm.nerdfonts.dev_terminal .. " Zsh",
    ["bash"] = wezterm.nerdfonts.cod_terminal_bash .. " Bash",
    ["sudo"] = wezterm.nerdfonts.fa_hashtag .. " sudo",
    ["git"] = GIT,
    ["gis"] = GIT,
    ["gss"] = GIT,
    ["gid"] = GIT,
    ["gilg"] = GIT,
    ["gsub"] = GIT,
    ["lua"] = wezterm.nerdfonts.seti_lua .. " Lua",
    ["wget"] = wezterm.nerdfonts.md_arrow_down_box .. " wget",
    ["curl"] = wezterm.nerdfonts.md_transit_connection_variant .. " curl",
    ["lg"] = LAZYGIT,
    ["lazygit"] = LAZYGIT,
    ["y"] = YAZI,
    ["yazi"] = YAZI,
    ["mamba"] = wezterm.nerdfonts.md_snake .. " Mamba",
    ["python"] = wezterm.nerdfonts.md_language_python .. " Python",
    ["ipython"] = wezterm.nerdfonts.md_language_python .. " iPython",
}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
---@param tab_info TabInformation
function titleParser.tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    local paneTitle = tab_info.active_pane.title
    local tabTitle = get_title[paneTitle:lower()]
    if tabTitle then
        return tabTitle
    end
    return paneTitle
end

return {
    titleParser = titleParser,
}
