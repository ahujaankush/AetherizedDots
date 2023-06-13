local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")

return function(args)
	local slider = {}
	function slider:new()
		self.widget = wibox.widget({
			bar_shape = gears.shape.rounded_rect,
			bar_height = dpi(3),
			bar_color = x.background,
			bar_active_color = args.bar_active_color,
			handle_color = x.background,
			handle_shape = gears.shape.circle,
			handle_border_color = args.handle_border_color,
			handle_border_width = dpi(2),
			value = args.initial_value,
			widget = wibox.widget.slider,
		})

		self.button = wibox.widget({
			{
				image = icons.getIcon("beautyline/actions/scalable/blurimage.svg"),
				resize = true,
				clip_shape = helpers.rrect(beautiful.border_radius),
				widget = wibox.widget.imagebox,
			},
			shape = helpers.rrect(beautiful.border_radius),
			widget = wibox.container.background,
		})

		self.container = wibox.widget({
			{
				{
					{
						self.button,
						strategy = "exact",
						height = dpi(30),
						widget = wibox.container.constraint,
					},
					self.widget,
					layout = wibox.layout.fixed.horizontal,
					spacing = dpi(15),
					widget = wibox.container.margin,
				},
				left = dpi(15),
				right = dpi(15),
				top = dpi(7),
				bottom = dpi(7),
				widget = wibox.container.margin,
			},
      forced_height = dpi(50),
			bg = x.color0,
			shape = helpers.rrect(beautiful.border_radius),
			widget = wibox.container.background,
		})

		self.button:connect_signal("mouse::enter", function()
			self.button:set_bg(x.color8 .. "6D")
		end)

		self.button:connect_signal("mouse::leave", function()
			self.button:set_bg(x.color0)
		end)

		self.button:connect_signal("button::press", function()
			args.apply(self)
		end)
	end

	slider:new()
	return slider
end
