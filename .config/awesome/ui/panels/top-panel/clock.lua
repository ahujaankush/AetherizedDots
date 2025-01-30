local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
--- Clock Widget
--- ~~~~~~~~~~~~

return function()
	local color = beautiful.white
	local widget = wibox.widget({
		widget = wibox.widget.textclock,
		format = "%a %b %d, %I:%M %p",
		align = "center",
		valign = "center",
		font = beautiful.font_name .. "Medium 12",
	})

	widget.markup = helpers.ui.colorize_text(widget.text, color)
	widget:connect_signal("widget::redraw_needed", function()
		widget.markup = helpers.ui.colorize_text(widget.text, color)
	end)

	return widget
end
