-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.scrollback_lines = 50000
config.enable_scroll_bar = true
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.color_scheme = "tokyonight_storm"
config.enable_tab_bar = false

config.default_prog = { os.getenv("SHELL") }

local act = wezterm.action

config.keys = {
	{ key = "Enter", mods = "SHIFT|SUPER", action = act.SpawnWindow },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 2, button = "Left" } },
		action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
		mods = "SHIFT",
	},
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "SHIFT",
		action = act.ScrollToPrompt(-1),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "SHIFT",
		action = act.ScrollToPrompt(1),
	},
}

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
	regex = [[\bITF(\d+)\b]],
	format = "https://example.com/tasks/?t=$1",
})

-- and finally, return the configuration to wezterm
return config
