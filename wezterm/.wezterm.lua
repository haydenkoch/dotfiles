-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = {} 

-- This is where you actually apply your config choices
config.color_scheme = 'Catppuccin Mocha'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 15.0
config.window_close_confirmation = 'NeverPrompt'
-- and finally, return the configuration to wezterm
return config
