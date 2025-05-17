local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")

--- Quick Settings
--- ~~~~~~~~~~~~~~

local quick_settings_text = wibox.widget({
    font = beautiful.font_name .. "Medium 10",
    markup = helpers.ui.colorize_text("Quick Settings", "#666c79"),
    valign = "center",
    widget = wibox.widget.textbox,
})

--- Widgets
local airplane_mode = require(... .. ".airplane-mode")
local blue_light = require(... .. ".blue-light")
local dnd = require(... .. ".dnd")
local floating_mode = require(... .. ".floating-mode")
local microphone = require(... .. ".microphone")
local lock = require(... .. ".lock")

--- 4x4 grid of button
local buttons = wibox.widget({
    airplane_mode,
    blue_light,
    dnd,
    floating_mode,
    microphone,
    lock,
    spacing = dpi(18),
    forced_num_cols = 2,
    forced_num_rows = 3,
    layout = wibox.layout.grid,
})

local widget = wibox.widget({
    {
        {
            {
                {
                    font = beautiful.font_name .. "Medium 10",
                    markup = helpers.ui.colorize_text("Actions", "#666c79"),
                    valign = "top",
                    widget = wibox.widget.textbox,
                },
                {
                    nil,
                    {
                        nil,
                        buttons,
                        expand = "outside",
                        layout = wibox.layout.align.horizontal
                    },
                    spacing = dpi(10),
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                fill_space = true,
                layout = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            forced_width = dpi(175),
            forced_height = dpi(300),
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
        bg = beautiful.widget_bg,
        shape = helpers.ui.rrect(beautiful.border_radius),
    },
    margins = dpi(10),
    widget = wibox.container.margin,
})

return widget
