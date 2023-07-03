local wezterm = require("wezterm")

local Fonts = {}

function Fonts.setup(config)
	config.font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"CaskaydiaCove Nerd Font",
	})
	config.font_size = 13
	config.underline_thickness = "200%"
	config.underline_position = "-3pt"
	config.custom_block_glyphs = true
  config.anti_alias_custom_block_glyphs = true
end

return Fonts
