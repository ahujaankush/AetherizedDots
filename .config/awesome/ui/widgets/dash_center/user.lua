local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")
local beautiful = require("beautiful")
local colorMod = require("modules.color")
local rubato = require("modules.rubato")

local active = colorMod.color({ hex = x.foreground })
local inactive = colorMod.color({ hex = x.color7 })

local host_text = wibox.widget.textbox()

awful.spawn.easy_async_with_shell("hostname", function(out)
	-- Remove trailing whitespaces
	out = out:gsub("^%s*(.-)%s*$", "%1")
	host_text.markup = helpers.colorize_text("@" .. out, x.color7)
end)

host_text.font = beautiful.font_name .. " 12"

local exit = wibox.widget({
	markup = helpers.colorize_text("", inactive.hex),
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
			markup = os.getenv("USER"):gsub("^%l", string.upper),
			font = beautiful.font_name .. " 20",
			widget = wibox.widget.textbox,
		},
		host_text,
		spacing = dpi(3),
		layout = wibox.layout.fixed.vertical,
	},
	expand = "none",
	forced_height = dpi(75),
	layout = wibox.layout.align.vertical,
})

local function fade(from, to)
	local transition = colorMod.transition(from, to)
	local transitionFunc = rubato.timed({
		pos = 0,
		duration = 0.2,
		rate = user.animation_rate,
		intro = 0,
		outro = 0,
		easing = rubato.easing.zero,
		subscribed = function(pos)
			exit:set_markup_silently(helpers.colorize_text("", transition(pos).hex))
		end,
	})
	transitionFunc.target = 1
end

exit:connect_signal("mouse::enter", function()
	fade(inactive, active)
end)

exit:connect_signal("mouse::leave", function()
	fade(active, inactive)
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
