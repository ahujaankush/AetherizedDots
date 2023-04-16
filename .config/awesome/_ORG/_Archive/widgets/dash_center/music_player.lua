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
	text = "玲",
	widget = wibox.widget.textbox,
})

local next = wibox.widget({
	align = "center",
	font = "JetBrainsMono Nerd Font 16",
	text = "怜",
	widget = wibox.widget.textbox,
})

local play = wibox.widget({
	align = "center",
	font = "JetBrainsMono Nerd Font 16",
	markup = "契",
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

local name = wibox.widget({
	markup = "<b>Nothing Playing</b>",
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 18",
	widget = wibox.widget.textbox,
})

local artist_name = wibox.widget({
	markup = "None",
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 10",
	widget = wibox.widget.textbox,
})

local player = wibox.widget({
	markup = "Nothing Playing",
	align = "left",
	valign = "center",
	font = beautiful.font_name .. " 10",
	widget = wibox.widget.textbox,
})

-- Get Song Info
playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
	art:set_image(gears.surface.load_uncached(album_path))
	name:set_markup_silently(helpers.colorize_text(helpers.bold_text(title), x.foreground))
	artist_name:set_markup_silently(artist)
  player:set_markup_silently("Now Playing • "..player_name)
	naughty.notify({ title = title, text = artist, icon = album_path })
end)

playerctl:connect_signal("playback_status", function(_, playing, _)
	if playing then
		play:set_markup_silently(helpers.colorize_text("", beautiful.pri))
		position.color = x.foreground
	else
		play:set_markup_silently("契")
		position.color = x.foreground .. "66"
	end
end)

playerctl:connect_signal("position", function(_, a, b, _)
	position.markup = a.." - "..b
end)

return wibox.widget({
	{
		{
			art,
			{
				{
					{
            player,
						name,
						artist_name,
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
            layout = wibox.layout.align.horizontal
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
