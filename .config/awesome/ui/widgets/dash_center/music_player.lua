local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")
local naughty = require("naughty")
local gears = require("gears")
local bling = require("modules.bling")
local playerctl = bling.signal.playerctl.lib()

local prev = wibox.widget({
	align = "center",
	font = "JetBrainsMono Nerd Font 16",
	text = "",
	widget = wibox.widget.textbox,
})

local next = wibox.widget({
	align = "center",
	font = "JetBrainsMono Nerd Font 16",
	text = "",
	widget = wibox.widget.textbox,
})

local play = wibox.widget({
	align = "center",
	font = "JetBrainsMono Nerd Font 16",
	markup = "",
	widget = wibox.widget.textbox,
})

play:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:play_pause()
end)))

next:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:next()
end)))

prev:buttons(gears.table.join(awful.button({}, 1, function()
	playerctl:previous()
end)))

local position = wibox.widget({
	align = "center",
	font = beautiful.font_name .. " 12",
	text = "00:00",
	widget = wibox.widget.textbox,
})

local art = wibox.widget({
	image = beautiful.player_img,
	resize = false,
	opacity = 0.75,
	forced_width = beautiful.dash_center_width - dpi(40),
	widget = wibox.widget.imagebox,
})

local title_widget = wibox.widget({
	markup = helpers.bold_text("Nothing Playing"),
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 18",
	widget = wibox.widget.textbox,
})

local artist_widget = wibox.widget({
	markup = "None",
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 10",
	widget = wibox.widget.textbox,
})

local player_widget = wibox.widget({
	markup = "None",
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 10",
	widget = wibox.widget.textbox,
})

-- Get Song Info
playerctl:connect_signal("metadata", function(_, title, artist, album_path, _, new, player_name)
	if new == true and title ~= "" then
		naughty.notify({ title = title, text = artist, image = album_path })
		-- Set art widget
		art:set_image(gears.surface.load_uncached(album_path))

		-- Set player name, title and artist widgets
		player_widget:set_markup_silently(helpers.colorize_text(player_name, x.foreground))
		title_widget:set_markup_silently(helpers.colorize_text(title, x.foreground))
		artist_widget:set_markup_silently(helpers.colorize_text(artist, x.foreground))
	end
end)

playerctl:connect_signal("no_players", function()
	art:set_image(beautiful.player_img)
	player_widget:set_markup_silently("None")
	title_widget:set_markup_silently(helpers.bold_text("Nothing Playing"))
	artist_widget:set_markup_silently("None")
end)

playerctl:connect_signal("playback_status", function(_, playing, _)
	if playing then
		play.markup = ""
	else
		play.markup = ""
	end
end)

return wibox.widget({
	{
		{
			art,
			{
				{
					{
						player_widget,
						title_widget,
						artist_widget,
						layout = wibox.layout.fixed.vertical,
					},
					nil,
					{
						{
							prev,
							play,
							next,
							spacing = dpi(6),
							layout = wibox.layout.fixed.horizontal,
						},
						nil,
						position,
						layout = wibox.layout.align.horizontal,
					},
					layout = wibox.layout.align.vertical,
				},
				margins = dpi(20),
				widget = wibox.container.margin,
			},
			layout = wibox.layout.stack,
		},
		shape = helpers.rrect(beautiful.border_radius),
		bg = x.background,
		widget = wibox.container.background,
	},
	widget = wibox.container.margin,
	margins = {
		left = dpi(20),
		right = dpi(20),
	},
	forced_height = dpi(225),
})
