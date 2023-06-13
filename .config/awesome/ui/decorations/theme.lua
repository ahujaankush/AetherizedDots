local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local keys = require("keys")
local decorations = require("ui.decorations")

-- This decoration theme will round clients according to your theme's
-- border_radius value
-- decorations.enable_rounding()

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
	awful
		.titlebar(c, { font = beautiful.titlebar_font, position = beautiful.titlebar_position, size = beautiful.titlebar_size })
		:setup({
			{
				{
					{
						awful.titlebar.widget.iconwidget(c),
						margins = dpi(5),
						widget = wibox.container.margin,
					},
					bg = x.color0,
					shape = helpers.rrect(beautiful.border_radius),
					widget = wibox.container.background,
				},
				margins = {
					bottom = beautiful.border_width,
				},
				widget = wibox.container.margin,
			},
			{
				{
					align = "left",
					valign = "center",
					widget = awful.titlebar.widget.titlewidget(c),
				},
				margins = {
					left = dpi(10),
					bottom = beautiful.border_width,
				},
				widget = wibox.container.margin,
			},
			{
				{
					{
						awful.titlebar.widget.minimizebutton(c),
						awful.titlebar.widget.maximizedbutton(c),
						awful.titlebar.widget.closebutton(c),
						layout = wibox.layout.fixed.horizontal,
					},
					bg = x.color0,
					widget = wibox.container.background,
					shape = helpers.rrect(beautiful.border_radius),
				},
				margins = {
					bottom = beautiful.border_width,
				},
				widget = wibox.container.margin,
			},
			layout = wibox.layout.align.horizontal,
		})
end)
