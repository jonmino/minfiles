-- This file defines the Keybindings
-- Pull in the wezterm API
local wezterm = require("wezterm")
-- imports/aliases
local colors = require("theme").colors
local act = wezterm.action
local config = {}

config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2500 }
config.keys = {
    { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
    {
        key = "Space",
        mods = "LEADER",
        action = act.SendKey({ key = "Space", mods = "CTRL" }),
    }, -- To be able to send CTRL Space
    { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "=", mods = "LEADER", action = act.ResetFontSize },
    {
        key = "-",
        mods = "LEADER",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "/",
        mods = "LEADER",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },
    { key = "f", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
    { key = "R", mods = "LEADER", action = act.ReloadConfiguration },
    { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "c", mods = "LEADER", action = act.ActivateCopyMode },
    {
        key = "e",
        mods = "LEADER",
        action = act.PromptInputLine({
            description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { Color = colors.mauve } },
                { Text = "Renaming Tab Title...:" },
            }),
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
    },
    { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
    {
        key = "m",
        mods = "LEADER",
        action = act.ActivateKeyTable({
            name = "move_tab",
            one_shot = false,
            prevent_fallback = false,
            replace_current = false,
            until_unknown = false,
        }),
    },
    { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
    { key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
    { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
    {
        key = "r",
        mods = "LEADER",
        action = act.ActivateKeyTable({
            name = "resize_pane",
            one_shot = false,
            prevent_fallback = false,
            replace_current = false,
            until_unknown = false,
        }),
    },
    { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "p", mods = "LEADER", action = act.PasteFrom("Clipboard") },
    { key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = false }) },
    {
        key = "w",
        mods = "LEADER",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    {
        key = "d",
        mods = "LEADER",
        action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS" }),
    },
    -- Prompt for a name to use for a new workspace and switch to it.
    {
        key = "W",
        mods = "LEADER",
        action = act.PromptInputLine({
            description = wezterm.format({
                { Attribute = { Intensity = "Bold" } },
                { Foreground = { AnsiColor = "Fuchsia" } },
                { Text = "Enter name for new workspace" },
            }),
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace({
                            name = line,
                        }),
                        pane
                    )
                end
            end),
        }),
    },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
}
config.key_tables = {
    move_tab = {
        { key = "Enter", mods = "NONE", action = act.PopKeyTable },
        { key = "Escape", mods = "NONE", action = act.PopKeyTable },
        { key = "h", mods = "NONE", action = act.MoveTabRelative(-1) },
        { key = "j", mods = "NONE", action = act.MoveTabRelative(-1) },
        { key = "k", mods = "NONE", action = act.MoveTabRelative(1) },
        { key = "l", mods = "NONE", action = act.MoveTabRelative(1) },
    },

    resize_pane = {
        { key = "Enter", mods = "NONE", action = act.PopKeyTable },
        { key = "Escape", mods = "NONE", action = act.PopKeyTable },
        { key = "h", mods = "NONE", action = act.AdjustPaneSize({ "Left", 1 }) },
        { key = "j", mods = "NONE", action = act.AdjustPaneSize({ "Down", 1 }) },
        { key = "k", mods = "NONE", action = act.AdjustPaneSize({ "Up", 1 }) },
        { key = "l", mods = "NONE", action = act.AdjustPaneSize({ "Right", 1 }) },
    },
}
-- Quickly navigate Tabs with Index
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end
-- return the configuration to wezterm
return config
