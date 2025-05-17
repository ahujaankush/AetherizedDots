local wibox                      = require("wibox")
local awful                      = require("awful")
local beautiful                  = require("beautiful")
local dpi                        = require("beautiful").xresources.apply_dpi
local gears                      = require("gears")
local bling                      = require("modules.bling")
local helpers                    = require("helpers")
local playerctl                  = bling.signal.playerctl.lib()

local art                        = wibox.widget {
    image = beautiful.wallpaper,
    opacity = 0.25,
    forced_height = dpi(240),
    forced_width = dpi(405),
    widget = wibox.widget.imagebox
}

local create_equalizer_stick     = function(height)
    return wibox.widget {
        {
            valign = 'center',
            shape = helpers.ui.rrect(beautiful.border_radius),
            forced_height = height,
            forced_width = 3,
            bg = beautiful.accent .. 'cc',
            widget = wibox.container.background
        },
        widget = wibox.container.place,
    }
end

local visualizer                 = wibox.widget {
    create_equalizer_stick(20),
    create_equalizer_stick(10),
    create_equalizer_stick(15),
    create_equalizer_stick(19),
    create_equalizer_stick(8),
    create_equalizer_stick(23),
    spacing = dpi(5),
    layout = wibox.layout.fixed.horizontal,
}

local song_name                  = wibox.widget {
    markup = 'Nothing Playing',
    align = 'left',
    valign = 'center',
    font = beautiful.font_name .. "13",
    forced_width = dpi(40),
    widget = wibox.widget.textbox
}

local artist_name                = wibox.widget {
    markup = 'None',
    align = 'left',
    valign = 'center',
    forced_height = dpi(20),
    widget = wibox.widget.textbox
}

local status                     = wibox.widget {
    markup = 'Paused',
    align = 'left',
    valign = 'bottom',
    forced_height = dpi(20),
    widget = wibox.widget.textbox
}

local previous_button            = wibox.widget {
    align = 'center',
    font = beautiful.icon_font .. "24",
    text = '󰒮',
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:previous()
        end)
    },
}

local next_button                = wibox.widget {
    align = 'center',
    font = beautiful.icon_font .. "24",
    text = '󰒭',
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:next()
        end)
    },
}

local play_button                = wibox.widget {
    align = 'center',
    font = beautiful.icon_font .. "24",
    markup = helpers.ui.colorize_text('󰐊', beautiful.accent),
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:play_pause()
        end)
    },
}

local slider                     = wibox.widget {
    bar_height       = dpi(6),
    handle_color     = beautiful.accent,
    bar_color        = beautiful.accent .. '22',
    bar_active_color = beautiful.accent,
    handle_shape     = gears.shape.rectangle,
    handle_width     = dpi(8),
    forced_height    = dpi(6),
    forced_width     = 100,
    maximum          = 100,
    widget           = wibox.widget.slider,
}

local is_player_progress_hovered = false

slider:connect_signal('mouse::enter', function()
    is_player_progress_hovered = true
end)

slider:connect_signal('mouse::leave', function()
    is_player_progress_hovered = false
end)

slider:connect_signal('property::value', function(_, value)
    if is_player_progress_hovered then
        playerctl:set_position(value)
    end
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec)
    length_sec = length_sec == 0 and 100 or length_sec -- default of 0 causes issues with rendering
    slider.maximum = length_sec
    slider.value = interval_sec
end)

playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    if title == "" then
        title = "None"
    end
    if artist == "" then
        artist = "Unknown"
    end
    if album_path == "" then
        album_path = beautiful.wallpaper
    end
    if string.len(title) > 30 then
        title = string.sub(title, 0, 30) .. "..."
    end
    if string.len(artist) > 22 then
        artist = string.sub(artist, 0, 22) .. "..."
    end
    song_name:set_markup_silently(title)
    artist_name:set_markup_silently(artist)
    art.image = helpers.ui.crop_surface(1.5, gears.surface.load_uncached(album_path))
end)

playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
end)

playerctl:connect_signal("playback_status", function(_, playing, player_name)
    play_button.markup = playing and helpers.ui.colorize_text("󰏤", beautiful.accent) or
        helpers.ui.colorize_text("󰐊", beautiful.accent)
    status.markup = playing and "Playing" or "Paused"
end)

local art_section = wibox.widget({
    {
        {
            art,
            {
                {
                    widget = wibox.widget.textbox,
                },
                bg = {
                    type = "linear",
                    from = { 0, 0 },
                    to = { 250, 0 },
                    stops = { { 0, beautiful.widget_bg .. "00" }, { 1, beautiful.widget_bg .. "DD" } }
                },
                widget = wibox.container.background,
            },
            {
                nil,
                {
                    {
                        {
                            song_name,
                            artist_name,
                            spacing = dpi(3),
                            layout = wibox.layout.fixed.vertical,
                        },
                        nil,
                        {
                            status,
                            nil,
                            visualizer,
                            layout = wibox.layout.align.horizontal,
                        },
                        expand = 'none',
                        layout = wibox.layout.align.vertical,
                    },
                    widget = wibox.container.margin,
                    margins = dpi(15)
                },
                slider,
                layout = wibox.layout.align.vertical,
            },
            layout = wibox.layout.stack,
        },
        shape = helpers.ui.rrect(beautiful.border_radius),
        widget = wibox.container.background,
    },
    widget = wibox.container.margin,
    margins = dpi(10)
})

local playerctl_section = wibox.widget({
    {
        {
            {
                previous_button,
                {
                    {
                        play_button,
                        widget = wibox.container.margin,
                        margins = dpi(5),
                    },
                    shape = helpers.ui.rrect(beautiful.border_radius),
                    widget = wibox.container.background,
                    bg = beautiful.accent .. "11"
                },
                next_button,
                expand = 'none',
                layout = wibox.layout.align.vertical,
            },
            widget = wibox.container.margin,
            margins = dpi(10)
        },
        shape = helpers.ui.rrect(beautiful.border_radius),
        bg = beautiful.widget_bg,
        widget = wibox.container.background,
    },
    widget = wibox.container.margin,
    margins = dpi(10)
})

local music = wibox.widget({
    art_section,
    playerctl_section,
    fill_space = true,
    layout = wibox.layout.fixed.horizontal,
})

return music
