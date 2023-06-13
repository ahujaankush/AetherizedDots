local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local awful = require("awful")
local container = require("ui.widgets.sidebar.playground.container")
local slider = require("ui.widgets.sidebar.playground.entry.slider")
local initial_blur_strength = 0

local container_widget = container({
	width = beautiful.sidebar_width,
	height = dpi(400),
})
awful.spawn.easy_async_with_shell(
	[[bash -c "
		grep -F 'blur-strength =' $HOME/.config/picom/picom.conf | 
		awk 'NR==1 {print $3}' | tr -d ';'
		"]],
	function(stdout, _)
		initial_blur_strength = stdout:match("%d+")

		container_widget:add(slider({
			bar_active_color = x.color3,
			handle_border_color = x.color3,
			initial_value = math.floor(tonumber(initial_blur_strength) * 5),
			apply = function(self)
				awful.spawn.with_shell(
					[[bash -c "sed -i 's/.*blur-strength = .*/blur-strength = ]]
						.. math.floor(self.widget:get_value() / 5)
						.. [[;/g' \$HOME/.config/picom/picom.conf"]]
				)
			end,
		}).container)
	end
)

local title = wibox.widget({

	markup = helpers.bold_text(
		helpers.colorize_text("P", x.color1)
			.. helpers.colorize_text("L", x.color2)
			.. helpers.colorize_text("A", x.color3)
			.. helpers.colorize_text("Y", x.color4)
			.. helpers.colorize_text("G", x.color5)
			.. helpers.colorize_text("R", x.color6)
			.. helpers.colorize_text("O", x.color9)
			.. helpers.colorize_text("U", x.color10)
			.. helpers.colorize_text("N", x.color11)
			.. helpers.colorize_text("D", x.color12)
			.. helpers.colorize_text(".", x.color13)
			.. helpers.colorize_text("L", x.color14)
			.. helpers.colorize_text("U", x.color1)
			.. helpers.colorize_text("A", x.color2)
	),
	font = beautiful.font_name .. " 16",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox,
})

local description = wibox.widget({
	widget = wibox.container.scroll.horizontal,
	step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
	speed = 60,
	{
		markup = helpers.colorize_text("AwesomeWM Scripts and Configuration Module", x.color7),
		font = beautiful.font_name .. " 12",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	},
})

return wibox.widget({
	{
		{
			{
				{
					nil,
					{
						resize = true,
						image = icons.getIcon("Miya-icon-theme/src/apps/scalable/3Depict.svg"),
						clip_shape = helpers.rrect(beautiful.border_radius - 3),
						widget = wibox.widget.imagebox,
					},
					layout = wibox.layout.align.vertical,
				},
				{
					title,
					description,
					layout = wibox.layout.align.vertical,
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {
				left = dpi(15),
				right = dpi(15),
				top = dpi(7),
				bottom = dpi(7),
			},
			widget = wibox.container.margin,
		},
		nil,
		bg = x.color0,
		shape = helpers.rrect(beautiful.border_radius),
		forced_height = dpi(60),
		widget = wibox.container.background,
	},
	container_widget.layout,
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical,
})
