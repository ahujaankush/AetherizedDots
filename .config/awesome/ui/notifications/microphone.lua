local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local rubato = require("modules.rubato")

local microphone_icon = ""
local muted_color = x.color8
local active_color = x.color2

local microphone_overlay = wibox({
	bg = x.background,
	width = dpi(50),
	height = dpi(50),
	visible = false,
	ontop = true,
	shape = helpers.rrect(beautiful.border_radius),
	type = "normal",
	input_passthrough = true,
})

awful.placement.top_left(microphone_overlay, {
	margins = {
		top = beautiful.useless_gap + beautiful.wibar_height,
		left = beautiful.useless_gap,
	},
})

local indicator = wibox.widget({
	font = "icomoon 20",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox(microphone_icon),
})

microphone_overlay:setup({
	widget = indicator,
})

local animations = rubato.timed({
	pos = 0,
	rate = user.animation_rate,
	intro = 0.15,
	outro = 0.15,
	duration = 0.3,
	easing = rubato.easing.quadratic,
	subscribed = function(pos)
		microphone_overlay.y = mouse.screen.geometry.y + pos
	end,
})

local animations_timer = gears.timer({
	timeout = 0.2,
	single_shot = true,
	callback = function()
		microphone_overlay.visible = false
	end,
})

local hide_microphone_adjust = gears.timer({
	timeout = 3,
	autostart = true,
	callback = function()
		animations.target = -microphone_overlay.height
		animations_timer:again()
	end,
})

awesome.connect_signal("evil::microphone", function(muted)
	indicator.markup = helpers.colorize_text(microphone_icon, muted and muted_color or active_color)
	if microphone_overlay.visible then
		hide_microphone_adjust:again()
	else
		microphone_overlay.visible = true
		animations.target = beautiful.useless_gap + beautiful.wibar_height
		hide_microphone_adjust:start()
	end
end)
