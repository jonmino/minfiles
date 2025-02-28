-- Pull in the wezterm API
local wezterm = require("wezterm")
-- Pull in lib to merge tables
local mytable = require("tableLib").mytable
-- other config files
local appearance = require("appearance")
local bindings = require("bindings")

-- This table will hold the configuration.
local config = {}

-- Basic Settings:
-- change default domain to WSL
config.default_domain = "WSL:Ubuntu"
config.term = "wezterm"
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 5000
config.default_workspace = "main"
-- startup size
config.initial_rows = 36
config.initial_cols = 120
config.exit_behavior = "Close"
config.swallow_mouse_click_on_window_focus = true
-- Define Word delimiters
-- Without dot & slash to make paths one word
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*…$"
config.warn_about_missing_glyphs = false -- Annyoing because of the additional Window

-- Assemble config from different subfiles
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local fullConfig = {}

if wezterm.config_builder then
    fullConfig = wezterm.config_builder()
end

-- Include subconfigs
mytable.append_all(fullConfig, config, appearance, bindings)

-- return the configuration to wezterm
return fullConfig
