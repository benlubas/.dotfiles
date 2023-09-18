local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

if wezterm.target_triple == "aarch64-apple-darwin" then
  config.font_size = 14
  config.adjust_window_size_when_changing_font_size = true
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  print("Linux")
  config.font_size = 16
end

config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.warn_about_missing_glyphs = false

config.colors = {
  foreground = "#b2b2b2",
  background = "#101010",

  cursor_bg = "#9e9e9e",
  cursor_fg = "#101010",
  cursor_border = "#9e9e9e",

  selection_fg = "#101010",
  selection_bg = "#b2ceee",

  scrollbar_thumb = "#222222",

  ansi = {
    "#323437",
    "#ff5454",
    "#8cc85f",
    "#e3c78a",
    "#80a0ff",
    "#cf87e8",
    "#79dac8",
    "#c6c6c6",
  },
  brights = {
    "#949494",
    "#ff5189",
    "#36c692",
    "#c2c292",
    "#74b2ff",
    "#ae81ff",
    "#85dc85",
    "#e4e4e4",
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  indexed = { [136] = "#af8700" },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = "orange",

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = "#000000" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using one of the names "Black", "Maroon", "Green",
  --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = "Black" },
  copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

  quick_select_label_bg = { Color = "peru" },
  quick_select_label_fg = { Color = "#ffffff" },
  quick_select_match_bg = { AnsiColor = "Navy" },
  quick_select_match_fg = { Color = "#ffffff" },
}

config.enable_tab_bar = false
config.audible_bell = "Disabled"

-- allow both alt keys to be used as alt keys
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

local dd = wezterm.action.DisableDefaultAssignment
-- all these binds to change the font size
config.keys = {
  { key = "+", mods = "CTRL",        action = dd },
  { key = "+", mods = "SHIFT|CTRL",  action = dd },
  { key = "-", mods = "CTRL",        action = dd },
  { key = "-", mods = "SHIFT|CTRL",  action = dd },
  { key = "-", mods = "SUPER",       action = dd },
  { key = "=", mods = "CTRL",        action = dd },
  { key = "=", mods = "SHIFT|CTRL",  action = dd },
  { key = "=", mods = "SUPER",       action = dd },
  { key = "_", mods = "CTRL",        action = dd },
  { key = "_", mods = "SHIFT|CTRL",  action = dd },
  { key = "w", mods = "SUPER",       action = dd },
  { key = "w", mods = "SUPER|SHIFT", action = dd },
  { key = "m", mods = "SUPER",       action = dd },
}

return config
