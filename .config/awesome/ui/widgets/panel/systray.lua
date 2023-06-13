local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local mysystray = wibox.widget.systray()
mysystray.base_size = beautiful.systray_icon_size

return wibox.widget({
	{
		mysystray,
		top = dpi(7.25),
		left = dpi(10),
		right = dpi(10),
		widget = wibox.container.margin,
	},
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})
