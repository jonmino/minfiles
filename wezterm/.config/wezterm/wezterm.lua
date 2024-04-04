-- Pull in the wezterm API
local wezterm = require("wezterm")
-- other config files
local app = require("appearance")
local bindings = require("bindings")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Basic Settings:
-- change default domain to WSL
config.default_domain = "WSL:Ubuntu"
config.term = "wezterm"
config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte, nord
config.font = wezterm.font_with_fallback({
	{
		family = "MonaspiceNe NFM Medium",
		weight = "Regular",
		italic = false,
		scale = 1, -- The code below activates font ligatures
		harfbuzz_features = {
			"liga=1",
			"dlig=1",
			"calt=1",
			"clig=1",
			"ss01=1",
			"ss02=1",
			"ss03=1",
			"ss04=1",
			"ss05=1",
			"ss06=1",
			"ss07=1",
			"ss08=1", }
	},
	{ family = "MesloLGS NF",                             scale = 1 },
	{ family = "SourceCodePro+Powerline+Awesome+Regular", scale = 1 },
})
config.adjust_window_size_when_changing_font_size = false
config.font_size = 14
config.line_height = 1
config.window_background_opacity = 0.9
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 5000
config.enable_scroll_bar = false
config.default_workspace = "main"
-- startup size
config.initial_rows = 36
config.initial_cols = 120
-- Visual Settings:
-- inactive panes
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.6,
}
-- Tab bar
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE" -- TITLE und RESIZE / INTEGRATED_BUTTONS|RESIZE
config.integrated_title_button_style = "Windows"          -- Styles = Windows, MacOSNative, Gnome
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.tab_bar_style = app.tab_bar_style

-- Keybindings
config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2500 }
config.keys = bindings.keys
config.key_tables = bindings.key_tables

-- return the configuration to wezterm
return config
