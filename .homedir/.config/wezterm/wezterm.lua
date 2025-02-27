﻿-- Pull in the wezterm API
local wezterm = require("wezterm")
-- Pull in lib to merge tables
local mytable = require("tableLib").mytable
-- other config files
local appearance = require("appearance")
local bindings = require("bindings")

-- This table will hold the configuration.
local generalSettings = {}

-- Basic Settings:
-- change default domain to WSL
generalSettings.default_domain = "WSL:Ubuntu"
generalSettings.term = "wezterm"
generalSettings.adjust_window_size_when_changing_font_size = false
generalSettings.window_close_confirmation = "NeverPrompt"
generalSettings.scrollback_lines = 5000
generalSettings.default_workspace = "main"
-- startup size
generalSettings.initial_rows = 36
generalSettings.initial_cols = 120
generalSettings.exit_behavior = "Close"
generalSettings.swallow_mouse_click_on_window_focus = true
-- Define Word delimiters
-- Without dot & slash to make paths one word
generalSettings.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*…$"
generalSettings.warn_about_missing_glyphs = false -- Annyoing because of the additional Window

-- Assemble config from different subfiles
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local fullConfig = {}

if wezterm.config_builder then
    fullConfig = wezterm.config_builder()
end

-- Include subconfigs
mytable.append_all(fullConfig, generalSettings, appearance, bindings)

-- return the configuration to wezterm
return fullConfig
