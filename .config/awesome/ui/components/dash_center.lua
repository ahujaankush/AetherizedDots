local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local rubato = require("modules.rubato")

local dash_center_cont = wibox.widget({
	{
		require("ui.widgets.dash_center.user"),
		require("ui.widgets.dash_center.sliders"),
		require("ui.widgets.dash_center.field_panel"),
		require("ui.widgets.dash_center.music_player"),
		spacing = dpi(20),
		forced_width = beautiful.dash_center_width,
		layout = wibox.layout.fixed.vertical,
	},
	widget = wibox.container.margin,
	margins = {
		bottom = dpi(20),
	},
})

screen.connect_signal("request::desktop_decoration", function(s)
	s.dash_center = awful.popup({
		screen = s,
		widget = dash_center_cont,
		placement = function(c)
			awful.placement.top_right(c, {
				margins = {
					top = beautiful.wibar_height + beautiful.useless_gap,
					right = beautiful.useless_gap,
				},
			})
		end,
		ontop = true,
		visible = false,
		bg = x.background,
		fg = x.foreground,
		opacity = beautiful.dash_center_opacity,
	})

	s.dash_center_slide = rubato.timed({
		pos = s.geometry.y - s.dash_center.height,
		intro = 0.3,
		outro = 0.3,
		duration = 0.6,
		rate = user.animation_rate,
    easing = rubato.easing.quadratic,
		subscribed = function(pos)
			s.dash_center.y = s.geometry.y + pos
		end,
	})

	s.dash_center_timer = gears.timer({
		timeout = 0.5,
		single_shot = true,
		callback = function()
			s.dash_center.visible = false
		end,
	})

	s.dash_center_grabber = nil
end)

function dash_center_hide(s)
	s.dash_center_slide.target = s.geometry.y - s.dash_center.height
	s.dash_center_timer:start()
	awful.keygrabber.stop(s.dash_center_grabber)
end

function dash_center_show(s)
	-- naughty.notify({text = "starting the keygrabber"})
	s.dash_center_grabber = awful.keygrabber.run(function(_, key, event)
		if event == "release" then
			return
		end
		-- Press Escape or q or F1 to hide itf
		if key == "Escape" or key == "q" or key == "F1" then
			dash_center_hide(s)
		end
	end)
	s.dash_center.visible = true
	s.dash_center_slide.target = s.geometry.y + beautiful.wibar_height + beautiful.useless_gap
end

function dash_center_toggle(s)
	if s.dash_center.visible then
		dash_center_hide(s)
	else
		dash_center_show(s)
	end
end
