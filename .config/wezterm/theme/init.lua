local wezterm = require("wezterm")

local Theme = {}

function Theme.get_colors()
	local THEME_NAME = "aether"
	return require("theme.palettes." .. THEME_NAME)
end

function Theme.setup(config)
	local colors = Theme.get_colors()

	config.colors = {
		split = colors.line,
		foreground = colors.white,
		background = colors.black,
		cursor_bg = colors.white,
		cursor_border = colors.one_bg3,
		cursor_fg = colors.black,
		selection_bg = colors.one_bg3,
		visual_bell = colors.one_bg,
		indexed = {
			[16] = colors.red,
			[17] = colors.pink,
		},
		scrollbar_thumb = colors.one_bg,
		compose_cursor = colors.nord_blue,
		ansi = {
			colors.black2,
			colors.red,
			colors.vibrant_green,
			colors.yellow,
			colors.nord_blue,
			colors.purple,
			colors.teal,
			colors.white,
		},
		brights = {
			colors.one_bg,
			colors.baby_pink,
			colors.green,
			colors.orange,
			colors.blue,
			colors.dark_purple,
			colors.cyan,
			colors.darker_white,
		},
		tab_bar = {
			background = colors.darker_black,
			active_tab = {
				bg_color = "none",
				fg_color = colors.white,
				intensity = "Bold",
				underline = "None",
				italic = true,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = colors.one_bg,
				fg_color = colors.light_grey,
			},
			inactive_tab_hover = {
				bg_color = colors.one_bg2,
				fg_color = colors.light_grey,
			},
			new_tab = {
				bg_color = colors.one_bg,
				fg_color = colors.light_grey,
			},
			new_tab_hover = {
				bg_color = colors.one_bg2,
				fg_color = colors.light_grey,
			},
		},
	}
end

return Theme
