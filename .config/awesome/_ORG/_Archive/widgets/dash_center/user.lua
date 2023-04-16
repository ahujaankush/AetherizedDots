local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")

local nickname = wibox.widget({
	markup = helpers.colorize_text(user.nickname, x.color7),
	font = beautiful.font_name .. " 12",
	widget = wibox.widget.textbox,
})

local exit = wibox.widget({
	markup = helpers.colorize_text("", x.color7),
	font = "icomoon bold 20",
	widget = wibox.widget.textbox,
})

local profile_picture = wibox.widget({
	image = user.profile_picture,
	resize = true,
	clip_shape = gears.shape.circle,
	forced_height = dpi(80),
	forced_width = dpi(80),
	widget = wibox.widget.imagebox,
})

local profile_text = wibox.widget({
	nil,
	{
		{
			markup = os.getenv("USER"),
			font = beautiful.font_name .. " 20",
			widget = wibox.widget.textbox,
		},
		nickname,
		spacing = dpi(3),
		layout = wibox.layout.fixed.vertical,
	},
	expand = "none",
	forced_height = dpi(75),
	layout = wibox.layout.align.vertical,
})

exit:connect_signal("mouse::enter", function()
	exit:set_markup_silently(helpers.colorize_text("", x.foreground))
end)

exit:connect_signal("mouse::leave", function()
	exit:set_markup_silently(helpers.colorize_text("", x.color7))
end)

exit:connect_signal("button::press", function()
  exit_screen_show()
end)



return wibox.widget({
	{
		{
			{
				profile_picture,
				profile_text,
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal,
			},
			nil,
			exit,
			layout = wibox.layout.align.horizontal,
		},
		margins = dpi(20),
		widget = wibox.container.margin,
	},
	bg = x.color0,
	widget = wibox.container.background,
})
