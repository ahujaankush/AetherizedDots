local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local rubato = require("modules.rubato")

local notify_cont = wibox.widget({
	require("ui.widgets.control_center.notif-center"),
	forced_width = dpi(400),
	forced_height = dpi(625),
	widget = wibox.container.margin,
})

local customCalendarWidget = require("ui.widgets.control_center.calendar")
customCalendarWidget.spacing = dpi(16)

local calendar_cont = wibox.widget({
	{
		require("ui.widgets.control_center.user"),
		require("ui.widgets.control_center.weather"),
		spacing = dpi(7.5),
		layout = wibox.layout.fixed.vertical,
	},

	{
		{
			nil,
			customCalendarWidget,
			expand = "none",
			forced_width = dpi(400),
			forced_height = dpi(475),
			layout = wibox.layout.align.horizontal,
		},
		bg = x.color0,
		widget = wibox.container.background,
		shape = helpers.rrect(beautiful.border_radius),
	},
	spacing = dpi(7.5),
	layout = wibox.layout.fixed.vertical,
})

local control_center_setup = wibox.widget({
	{
		calendar_cont,
		notify_cont,
		spacing = dpi(7.5),
		layout = wibox.layout.fixed.horizontal,
		widget = wibox.container.background,
		bg = x.background,
	},
	margins = dpi(15),
	widget = wibox.container.margin,
})

screen.connect_signal("request::desktop_decoration", function(s)
	s.control_center = awful.popup({
		screen = s,
		widget = control_center_setup,
		placement = function(c)
			awful.placement.top(c, {
				margins = {
					top = beautiful.wibar_height + beautiful.useless_gap,
				},
			})
		end,
		ontop = true,
		visible = false,
		fg = x.foreground,
		opacity = beautiful.control_center_opacity,
	})

	s.control_center_slide = rubato.timed({
		pos = s.geometry.y - s.control_center.height,
		intro = 0.25,
		outro = 0.25,
		duration = 0.5,
		rate = user.animation_rate,
		easing = rubato.easing.quadratic,
		subscribed = function(pos)
			s.control_center.y = s.geometry.y + pos
		end,
	})

	s.control_center_timer = gears.timer({
		timeout = 0.6,
		single_shot = true,
		callback = function()
			s.control_center.visible = false
		end,
	})

	s.control_center_grabber = nil
end)

function control_center_hide(s)
	s.control_center_slide.target = s.geometry.y - s.control_center.height
	s.control_center_timer:start()
	awful.keygrabber.stop(s.control_center_grabber)
end

function control_center_show(s)
	-- naughty.notify({text = "starting the keygrabber"})
	s.control_center_grabber = awful.keygrabber.run(function(_, key, event)
		if event == "release" then
			return
		end
		-- Press Escape or q or F1 to hide itf
		if key == "Escape" or key == "q" or key == "F1" then
			control_center_hide(s)
		end
	end)
	s.control_center.visible = true
	s.control_center_slide.target = beautiful.wibar_height + beautiful.useless_gap
	customCalendarWidget.date = os.date("*t")
end

function control_center_toggle(s)
	if s.control_center.visible then
		control_center_hide(s)
	else
		control_center_show(s)
	end
end
