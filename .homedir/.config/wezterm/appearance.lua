-- This file configures most of the appearance and visuals
-- Pull in the wezterm API
local wezterm = require("wezterm")
local titleParser = require("titleParser").titleParser
-- Colors
local BASE = "#1e1e2e"
local CRUST = "#11111b"
local MANTLE = "#181825"
local SURFACE0 = "#313244"
local SURFACE1 = "#45475a"
local TEXT = "#cdd6f4"
local SUBTEXT0 = "#a6adc8"
local RED = "#f38ba8"
local MAROON = "#eba0ac"
local PEACH = "#fab387"
local YELLOW = "#f9e2af"
local BLUE = "#89b4fa"
local SAPPHIRE = "#74c7ec"
local SKY = "#89dceb"
local MAUVE = "#cba6f7"
-- Symbols
-- The filled in variant of the (\uE0B0) symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the (\uE0B2) symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
-- Rectangle: "\u2588" -> █
local SOLID_RECTANGLE = "█"
-- Slash left: "\ue0ba" -> 
local SOLID_SLASH_LEFT = ""
-- Slash right: "\ue0bc" -> 
local SOLID_SLASH_RIGHT = ""
local THIN_SPACE = "\u{200A}"

-- Functions:

-- Current working directory
local shortcwd = function(fileurl)
    -- Nothing a little regex can't fix
    local filestr = fileurl.file_path
    filestr = string.gsub(filestr, "^(/home/)([^/\\]*)(/?.*)", "~%3")
    return string.gsub(filestr, "(.*[/\\])(.*[/\\])(.*)$", "%2%3")
end

local function button_style(bg, fg)
    return wezterm.format({
        { Background = { Color = fg } },
        { Foreground = { Color = bg } },
        { Text = SOLID_RIGHT_ARROW },
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = SOLID_RIGHT_ARROW },
    })
end

local function new_tab(bg, text)
    return wezterm.format({
        { Background = { Color = CRUST } },
        { Foreground = { Color = bg } },
        { Text = SOLID_SLASH_LEFT },
        { Background = { Color = bg } },
        { Foreground = { Color = text } },
        { Text = "+" },
        { Background = { Color = CRUST } },
        { Foreground = { Color = bg } },
        { Text = SOLID_SLASH_RIGHT },
    })
end

local function right_status_element(fg, next, text)
    return { Background = { Color = next } }, { Foreground = { Color = fg } }, { Text = SOLID_LEFT_ARROW }, {
        Background = { Color = fg },
    }, { Foreground = { Color = CRUST } }, { Text = text }
end

local config = {}

config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte, nord
config.window_background_opacity = 0.9
config.enable_scroll_bar = false
config.default_cursor_style = "SteadyBar"
config.cursor_thickness = "0.075cell"
config.underline_thickness = "0.15cell" -- Make line a bit thicker
config.inactive_pane_hsb = { -- Distinguish inactive from active pane
    saturation = 0.8,
    brightness = 0.6,
}
-- Font Settings
config.font = wezterm.font({
    family = "Monaspace Neon",
    weight = "Medium",
    italic = false,
    scale = 1, -- The code below activates font ligatures
    harfbuzz_features = {
        "liga=1",
        "dlig=1",
        "clig=1",
        "ss01=1",
        "ss02=1",
        "ss03=1",
        "ss04=1",
        "ss05=1",
        "ss06=1",
        "ss07=1",
        "ss08=1",
        "ss09=1",
        "ss10=1",
        "cv01=2",
        "cv02=0",
        "cv10=0",
        "cv11=0",
        "cv30=1",
        "cv31=1",
        "cv32=0",
        "cv60=0",
        "cv61=0",
        "cv62=0",
    },
})
config.font_size = 14
config.line_height = 1
config.strikethrough_position = "0.555cell" -- Define based on cell and not
config.underline_position = "-0.1cell" -- font specific for consistency
-- Use visual instead of audible bell
config.audible_bell = "Disabled"
config.visual_bell = {
    fade_in_function = "EaseIn",
    fade_in_duration_ms = 100,
    fade_out_function = "EaseOut",
    fade_out_duration_ms = 100,
}
config.colors = {
    visual_bell = MAROON,
}

config.window_decorations = "RESIZE" -- TITLE und RESIZE / INTEGRATED_BUTTONS|RESIZE
config.integrated_title_button_style = "Windows" -- Styles = Windows, MacOSNative, Gnome
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_max_width = 20

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = CRUST
    local LEFT_SEPERATOR = SOLID_SLASH_LEFT .. SOLID_RECTANGLE
    local RIGHT_SEPERATOR = SOLID_RECTANGLE .. SOLID_SLASH_RIGHT
    local background
    local foreground
    if tab.is_active then
        background = BASE
        foreground = PEACH
    elseif hover then
        background = SURFACE0
        foreground = SKY
    else
        background = CRUST
        foreground = SAPPHIRE
    end

    local edge_foreground = background

    local has_unseen_output = false
    local is_zoomed = false

    for _, pane in ipairs(panes) do
        if not tab.is_active and pane.has_unseen_output then
            has_unseen_output = true
        end
        if pane.is_zoomed then
            is_zoomed = true
        end
    end

    local title = titleParser.tab_title(tab)
    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_left(title, max_width - 6)
    local number = wezterm.truncate_left(tostring(tab.tab_index + 1), max_width - 4)

    return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = LEFT_SEPERATOR },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Background = { Color = foreground } },
        { Foreground = { Color = background } },
        { Text = RIGHT_SEPERATOR },
        { Text = number },
        { Background = { Color = edge_background } },
        { Foreground = { Color = foreground } },
        { Text = SOLID_SLASH_RIGHT },
    }
end)

-- Right Stauts
wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = RED
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = SAPPHIRE
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = MAUVE
    end

    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
    local cwd = pane:get_current_working_dir()
    cwd = cwd and shortcwd(cwd) or ""

    -- Time
    local time = wezterm.strftime("%H:%M")
    local date = wezterm.strftime("%Y-%m-%d")

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Background = { Color = CRUST } },
        { Foreground = { Color = stat_color } },
        { Text = SOLID_RECTANGLE },
        { Background = { Color = stat_color } },
        { Foreground = { Color = CRUST } },
        { Text = wezterm.nerdfonts.md_desktop_tower .. " " },
        { Background = { Color = CRUST } },
        { Foreground = { Color = stat_color } },
        { Text = SOLID_SLASH_RIGHT },
        { Text = " " .. stat },
        { Background = { Color = stat_color } },
        { Foreground = { Color = CRUST } },
        { Text = SOLID_RECTANGLE .. SOLID_SLASH_RIGHT },
        { Background = { Color = CRUST } },
        { Foreground = { Color = stat_color } },
        { Text = SOLID_SLASH_RIGHT },
    }))

    -- Right status
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    window:set_right_status(wezterm.format({
        right_status_element(PEACH, CRUST, wezterm.nerdfonts.md_folder .. THIN_SPACE .. cwd .. THIN_SPACE),
    }) .. wezterm.format({
        right_status_element(BLUE, PEACH, wezterm.nerdfonts.md_clock .. THIN_SPACE .. time .. THIN_SPACE),
    }) .. wezterm.format({
        right_status_element(MAUVE, BLUE, wezterm.nerdfonts.md_calendar .. THIN_SPACE .. date .. THIN_SPACE),
    }))
end)

config.tab_bar_style = {
    new_tab = new_tab(SURFACE0, SUBTEXT0),
    new_tab_hover = new_tab(SURFACE1, TEXT),
    window_hide = button_style(CRUST, PEACH),
    window_hide_hover = button_style(SURFACE0, YELLOW),
    window_maximize = button_style(CRUST, BLUE),
    window_maximize_hover = button_style(SURFACE0, SAPPHIRE),
    window_close = button_style(CRUST, RED),
    window_close_hover = button_style(SURFACE0, MAROON),
}
return config
