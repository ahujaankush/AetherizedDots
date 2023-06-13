local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local rubato = require("modules.rubato")

local component_margin = dpi(15)
-- calculate the number of rows
local rows = (math.modf(#awful.layout.layouts / 4) < #awful.layout.layouts / 4)
		and math.modf(#awful.layout.layouts / 4) + 1
	or #awful.layout.layouts / 4
local cols = 4

local ll = awful.widget.layoutlist({
	base_layout = wibox.widget({
		spacing = component_margin,
		forced_num_cols = cols,
		layout = wibox.layout.grid,
	}),
	widget_template = {
		{
			{
				id = "icon_role",
				forced_height = dpi(70),
				forced_width = dpi(70),
				widget = wibox.widget.imagebox,
			},
			margins = component_margin,
			widget = wibox.container.margin,
		},
		id = "background_role",
		forced_width = dpi(110),
		forced_height = dpi(110),
		widget = wibox.container.background,
	},
})

screen.connect_signal("request::desktop_decoration", function(s)
	s.layout_popup = awful.popup({
		widget = wibox.widget({
			nil,
			{
				ll,
				margins = component_margin,
				widget = wibox.container.margin,
			},
			expand = "none",
			layout = wibox.layout.align.vertical,
		}),
		placement = function(c)
			awful.placement.bottom_right(c, {

				margins = {
					bottom = beautiful.useless_gap,
					right = beautiful.useless_gap,
				},
			})
		end,
		ontop = true,
		visible = false,
	})

	s.layout_popup_anim = rubato.timed({
		pos = 0,
		duration = 0.3,
		intro = 0.15,
		outro = 0.15,
		rate = user.animation_rate,
		easing = rubato.easing.quadratic,
		subscribed = function(pos)
			s.layout_popup.y = s.geometry.height + pos
		end,
	})
	s.layout_popup_timer = gears.timer({
		timeout = 0.3,
		single_shot = true,
		callback = function()
			s.layout_popup.visible = false
		end,
	})

	s.layout_popup_grabber = nil
end)

function layout_popup_hide(s)
	s.layout_popup_anim.target = 0
	s.layout_popup_timer:start()
	awful.keygrabber.stop(s.layout_popup_grabber)
end

function layout_popup_show(s)
	-- naughty.notify({text = "starting the keygrabber"})
	s.layout_popup_grabber = awful.keygrabber.run(function(_, key, event)
		if event == "release" then
			return
		end
		-- Press Escape or q or F1 to hide itf
		if key == "Escape" or key == "q" or key == "F1" then
			layout_popup_hide(s)
		elseif key == "Right" then
			awful.layout.inc(1)
		elseif key == "Left" then
			awful.layout.inc(-1)
		elseif key == "Up" then
			awful.layout.inc(-cols)
		elseif key == "Down" then
			awful.layout.inc(cols)
		end
	end)
	s.layout_popup.visible = true
	s.layout_popup_anim.target = -s.layout_popup.height - beautiful.useless_gap
end

function layout_popup_toggle(s)
	if s.layout_popup.visible then
		layout_popup_hide(s)
	else
		layout_popup_show(s)
	end
end
