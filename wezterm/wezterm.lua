local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Visuals
config.color_scheme = 'nord'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'JetBrains Mono'

-- Utilities
config.enable_wayland = false

return config
