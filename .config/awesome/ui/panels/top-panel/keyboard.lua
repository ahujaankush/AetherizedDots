local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local wbutton = require("ui.widgets.button")
local helpers = require("helpers")

--- Keyboard Layout Widget
--- ~~~~~~~~~~~~~~

return function()
    local icon = wibox.widget({
        markup = helpers.ui.colorize_text("󰌌", beautiful.fg_normal),
        align = "center",
        valign = "center",
        font = beautiful.icon_font .. "Round 14",
        widget = wibox.widget.textbox,
    })

    local locked = true

    local country_code_text = wibox.widget({
        id = "percent_text",
        text = "-",
        font = beautiful.font_name .. "Medium 12",
        align = "center",
        valign = "center",
        visible = locked,
        widget = wibox.widget.textbox,
    })

    local function get_kblayout()
        awful.spawn.easy_async_with_shell(
            [[ setxkbmap -query | grep layout | awk '{print $2}' ]],
            function(stdout)
                local code = stdout:gsub("\n", "")
                country_code_text.markup = code
            end
        )
    end

    get_kblayout()

    awesome.connect_signal("widget::keyboard", function(layout)
        country_code_text.markup = layout
    end)

    local keyboard_layout = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        spacing = locked and dpi(5) or 0,
        icon,
        country_code_text,
    })

    local widget = wbutton.elevated.normal({
        child = keyboard_layout,
        normal_bg = beautiful.widget_bg,
        hover_bg = beautiful.one_bg,
        paddings = dpi(5),
        margins = {
            top = dpi(5),
            bottom = dpi(5)
        },
        on_hover = function(self)
            country_code_text.visible = true
            keyboard_layout.spacing = dpi(5)
        end,
        on_leave = function(self)
            country_code_text.visible = locked or false
            keyboard_layout.spacing = locked and dpi(5) or 0
        end,
        on_release = function(self)
            locked = not locked
        end,
        on_scroll_up = function()
            helpers.keyboard.switch_to_next_layout()
        end,
        on_scroll_down = function()
            helpers.keyboard.switch_to_previous_layout()
        end
    })

    return widget
end
