local helpers = require("helpers")
local beautiful = require("beautiful")
local wibox = require("wibox")

local separator_for_empty_msg = wibox.widget({
	orientation = "vertical",
	opacity = 0.0,
	widget = wibox.widget.separator,
})

return wibox.widget({
	separator_for_empty_msg,
	{
		{
			widget = wibox.widget.textbox,
			markup = helpers.colorize_text("󰂚", x.color4),
			font = "JetBrainsMono Nerd Font 84",
			valign = "center",
			align = "center",
		},
		{
			widget = wibox.widget.textbox,
			markup = helpers.colorize_text(helpers.bold_text("No Notifications"), x.foreground),
			font = beautiful.font_name .. " 16",
			valign = "center",
			align = "center",
		},
		spacing = dpi(10),
		layout = wibox.layout.fixed.vertical,
	},
	forced_height = dpi(600),
	separator_for_empty_msg,
	layout = wibox.layout.align.vertical,
	expand = "none",
})
