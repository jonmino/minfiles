-- This file configures most of the appearance and visuals
-- Pull in the wezterm API
local wezterm = require("wezterm")
local titleParser = require("titleParser").titleParser
-- Import Theme
local catppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
-- Import Colors and Symbols HACK:Should witch to table from Theme as soon as available
local theme = require("theme")
local colors = theme.colors
local symbols = theme.symbols

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
        { Text = symbols.solid_left_arrow },
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = symbols.solid_left_arrow },
    })
end

local function new_tab(bg, text)
    return wezterm.format({
        { Background = { Color = colors.crust } },
        { Foreground = { Color = bg } },
        { Text = symbols.slash_solid_right },
        { Background = { Color = bg } },
        { Foreground = { Color = text } },
        { Text = "+" },
        { Background = { Color = colors.crust } },
        { Foreground = { Color = bg } },
        { Text = symbols.slash_solid_left },
    })
end

local function right_status_element(fg, next, text)
    return { Background = { Color = next } }, { Foreground = { Color = fg } }, { Text = symbols.solid_left_arrow }, {
        Background = { Color = fg },
    }, { Foreground = { Color = colors.crust } }, { Text = text }
end

local config = {}

catppuccin.compose_cursor = colors.maroon -- HACK:There has to be a better way
config.color_schemes = { ["Catppuccin Mocha v2"] = catppuccin }
config.color_scheme = "Catppuccin Mocha v2"
config.window_background_opacity = 0.9
config.text_background_opacity = 1.0
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
    visual_bell = colors.red,
}

config.window_decorations = "RESIZE" -- TITLE und RESIZE / INTEGRATED_BUTTONS|RESIZE
config.integrated_title_button_style = "Windows" -- Styles = Windows, MacOSNative, Gnome
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_max_width = 20

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local edge_background = colors.crust
    local LEFT_SEPERATOR = symbols.slash_solid_right .. symbols.solid_rectangle
    local RIGHT_SEPERATOR = symbols.solid_rectangle .. symbols.slash_solid_left
    local background
    local foreground
    if tab.is_active then
        background = colors.base
        foreground = colors.peach
    elseif hover then
        background = colors.surface0
        foreground = colors.sky
    else
        background = colors.crust
        foreground = colors.sapphire
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
        { Text = symbols.slash_solid_left },
    }
end)

-- Right Stauts
wezterm.on("update-status", function(window, pane)
    -- Workspace name
    local stat = window:active_workspace()
    local stat_color = colors.red
    -- It's a little silly to have workspace name all the time
    -- Utilize this to display LDR or current key table name
    if window:active_key_table() then
        stat = window:active_key_table()
        stat_color = colors.sapphire
    end
    if window:leader_is_active() then
        stat = "LDR"
        stat_color = colors.mauve
    end

    -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l). Not a big deal, but check in case
    local cwd = pane:get_current_working_dir()
    cwd = cwd and shortcwd(cwd) or ""

    -- Time
    local time = wezterm.strftime("%H:%M")
    local date = wezterm.strftime("%Y-%m-%d")

    -- Left status (left of the tab line)
    window:set_left_status(wezterm.format({
        { Background = { Color = colors.crust } },
        { Foreground = { Color = stat_color } },
        { Text = symbols.solid_rectangle },
        { Background = { Color = stat_color } },
        { Foreground = { Color = colors.crust } },
        { Text = wezterm.nerdfonts.md_desktop_tower .. " " },
        { Background = { Color = colors.crust } },
        { Foreground = { Color = stat_color } },
        { Text = symbols.slash_solid_left },
        { Text = " " .. stat },
        { Background = { Color = stat_color } },
        { Foreground = { Color = colors.crust } },
        { Text = symbols.solid_rectangle .. symbols.slash_solid_left },
        { Background = { Color = colors.crust } },
        { Foreground = { Color = stat_color } },
        { Text = symbols.slash_solid_left },
    }))

    -- Right status
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    window:set_right_status(wezterm.format({
        right_status_element(
            colors.peach,
            colors.crust,
            wezterm.nerdfonts.md_folder .. symbols.thin_space .. cwd .. symbols.thin_space
        ),
    }) .. wezterm.format({
        right_status_element(
            colors.blue,
            colors.peach,
            wezterm.nerdfonts.md_clock .. symbols.thin_space .. time .. symbols.thin_space
        ),
    }) .. wezterm.format({
        right_status_element(
            colors.mauve,
            colors.blue,
            wezterm.nerdfonts.md_calendar .. symbols.thin_space .. date .. symbols.thin_space
        ),
    }))
end)

config.tab_bar_style = {
    new_tab = new_tab(colors.surface0, colors.subtext0),
    new_tab_hover = new_tab(colors.surface1, colors.text),
    window_hide = button_style(colors.crust, colors.peach),
    window_hide_hover = button_style(colors.surface0, colors.yellow),
    window_maximize = button_style(colors.crust, colors.blue),
    window_maximize_hover = button_style(colors.surface0, colors.sapphire),
    window_close = button_style(colors.crust, colors.red),
    window_close_hover = button_style(colors.surface0, colors.maroon),
}
return config
