local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")

local distroname = wibox.widget.textbox()
local kernel = wibox.widget.textbox()
local uptime = wibox.widget.textbox()

awful.spawn.easy_async_with_shell(
	[[
	cat /etc/os-release | awk 'NR==1'| awk -F '=' '{print $2}'
	]],
	function(stdout)
		distroname:set_markup(stdout:gsub("%\n", ""))
	end
)

awful.spawn.easy_async_with_shell(
	[[
	uname -r
	]],
	function(stdout)
		kernel:set_markup(stdout:gsub("%\n", ""))
	end
)

awful.widget.watch("uptime -p", 60, function(_, stdout)
	-- Remove trailing whitespaces
	local out = stdout:gsub("^%s*(.-)%s*$", "%1")
	uptime:set_markup(out)
end)

return wibox.widget({
	{
		{
			{
				{
					nil,
					{
						{
							image = user.profile_picture,
							resize = true,
							clip_shape = helpers.rrect(beautiful.border_radius - 3),
							widget = wibox.widget.imagebox,
						},
						strategy = "exact",
						width = dpi(60),
						widget = wibox.container.constraint,
					},
					expand = "none",
					layout = wibox.layout.align.vertical,
				},
				left = dpi(15),
				right = dpi(15),
				widget = wibox.container.margin,
			},
			{
				{
					nil,
					{
						{
							markup = helpers.bold_text("Welcome, " .. os.getenv("USER"):upper()),
							widget = wibox.widget.textbox,
						},
						distroname,
						kernel,
						uptime,
						layout = wibox.layout.fixed.vertical,
					},
					nil,
					expand = "none",
					layout = wibox.layout.align.vertical,
				},
				margins = dpi(8),
				widget = wibox.container.margin,
			},
			layout = wibox.layout.align.horizontal,
		},
		top = dpi(2),
		bottom = dpi(2),
		widget = wibox.container.margin,
	},
	bg = x.color0,
	shape = helpers.rrect(beautiful.border_radius),
	widget = wibox.container.background,
})
