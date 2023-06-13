local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi
local rubato = require("modules.rubato")

local width = dpi(50)
local height = dpi(300)

local active_color_1 = {
	type = "linear",
	from = { 0, 0 },
	to = { height },
	stops = { { 0, x.color6 }, { 0.50, x.color13 } },
}

local volume_icon = wibox.widget({
	{
		widget = wibox.widget.textbox,
		markup = helpers.colorize_text("", x.color6),
		font = "JetBrainsMono Nerd Font 22",
		valign = "center",
		align = "center",
	},
	margins = dpi(5),
	widget = wibox.container.margin,
})

local volume_adjust = awful.popup({
	type = "notification",
	maximum_width = width,
	maximum_height = height,
	visible = false,
	ontop = true,
	widget = wibox.container.background,
	shape = helpers.rrect(beautiful.border_radius),
	bg = "#00000000",
	placement = function(c)
		awful.placement.right(c, { margins = { right = 10 } })
	end,
})

local volume_bar = wibox.widget({
	bar_shape = gears.shape.rounded_rect,
	shape = gears.shape.rounded_rect,
	background_color = beautiful.notification_osd_indicator_bg,
	color = active_color_1,
	max_value = 100,
	value = 0,
	widget = wibox.widget.progressbar,
})

local volume_ratio = wibox.widget({
	layout = wibox.layout.ratio.vertical,
	{
		{ volume_bar, direction = "east", widget = wibox.container.rotate },
		top = dpi(20),
		left = dpi(20),
		right = dpi(20),
		widget = wibox.container.margin,
	},
	volume_icon,
	nil,
})

volume_ratio:adjust_ratio(2, 0.72, 0.28, 0)

volume_adjust.widget = wibox.widget({
	volume_ratio,
	border_width = beautiful.border_width * 0,
	border_color = beautiful.border_color,
	bg = beautiful.notification_osd_bg,
	opacity = beautiful.notification_osd_opacity,
	widget = wibox.container.background,
})

local animations = rubato.timed({
	pos = 0,
	rate = user.animation_rate,
	intro = 0.15,
	outro = 0.15,
	duration = 0.3,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		volume_adjust.maximum_height = pos
	end,
})

local animations_timer = gears.timer({
	timeout = 0.3,
	single_shot = true,
	callback = function()
		volume_adjust.visible = false
		volume_bar.mouse_enter = false
	end,
})

-- create a 3 second timer to hide the volume adjust
-- component whenever the timer is started
local hide_volume_adjust = gears.timer({
	timeout = 3,
	autostart = true,
	callback = function()
		animations.target = 0
		animations_timer:again()
	end,
})

awesome.connect_signal("evil::volume", function(volume, muted)
	volume_bar.value = volume

	if muted == true then
		volume_bar.color = x.color8
	else
		volume_bar.color = active_color_1
	end

	if volume_adjust.visible then
		hide_volume_adjust:again()
	else
		volume_adjust.visible = true
		animations.target = height
		hide_volume_adjust:start()
	end
end)
