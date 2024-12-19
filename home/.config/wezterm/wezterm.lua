local wezterm = require("wezterm")

return {
  color_scheme   = "Catppuccin Frappe",

  default_prog = { "zsh", "-c", "tmux" },
  enable_tab_bar = false,

  font           = wezterm.font("JetBrains Mono NF"),
  font_size      = 14.0,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
