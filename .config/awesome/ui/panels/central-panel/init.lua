local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")

--- AWESOME Central panel
--- ~~~~~~~~~~~~~~~~~~~~~

return function(s)
    --- Header
    local function header()
        local awesomewm = wibox.widget({
            {
                image = beautiful.distro,
                resize = true,
                halign = "center",
                valign = "center",
                widget = wibox.widget.imagebox,
            },
            strategy = "exact",
            height = dpi(30),
            widget = wibox.container.constraint,
        })

        local function search_box()
            local search_icon = wibox.widget({
                font = "icomoon bold 12",
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox(),
            })

            local reset_search_icon = function()
                search_icon.markup = helpers.ui.colorize_text("", beautiful.accent)
            end
            reset_search_icon()

            local search_text = wibox.widget({
                --- markup = helpers.ui.colorize_text("Search", beautiful.color8),
                align = "center",
                valign = "center",
                font = beautiful.font,
                widget = wibox.widget.textbox(),
            })

            local search = wibox.widget({
                {
                    {
                        search_icon,
                        {
                            search_text,
                            bottom = dpi(2),
                            widget = wibox.container.margin,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = dpi(10),
                    widget = wibox.container.margin,
                },
                forced_height = dpi(35),
                shape = helpers.ui.rrect(beautiful.border_radius),
                bg = beautiful.wibar_bg,
                widget = wibox.container.background(),
            })

            local function generate_prompt_icon(icon, color)
                return "<span font='icomoon 12' foreground='" .. color .. "'>" .. icon .. "</span> "
            end

            local function activate_prompt(action)
                search_icon.visible = false
                local prompt
                if action == "run" then
                    prompt = generate_prompt_icon("", beautiful.accent)
                elseif action == "web_search" then
                    prompt = generate_prompt_icon("", beautiful.accent)
                end
                helpers.misc.prompt(action, search_text, prompt, function()
                    search_icon.visible = true
                end)
            end

            search:buttons(gears.table.join(
                awful.button({}, 1, function()
                    activate_prompt("run")
                end),
                awful.button({}, 3, function()
                    activate_prompt("web_search")
                end)
            ))

            return search
        end

        local widget = wibox.widget({
            wibox.widget({
                awesomewm,
                search_box(),
                spacing = dpi(20),
                fill_space = true,
                layout = wibox.layout.fixed.horizontal,
            }),
            margins = dpi(10),
            widget = wibox.container.margin,
        })

        return widget
    end

    local widget_contents = wibox.widget {
        {
            {
                header(),
                margins = { top = dpi(10), bottom = dpi(10), right = dpi(20), left = dpi(20) },
                widget = wibox.container.margin,
            },
            {
                {
                    {
                        {
                            {
                                -- s.slider,
                                require("ui.panels.central-panel.quick-settings"),
                                forced_height = dpi(300),
                                layout = wibox.layout.fixed.vertical,
                            },
                            require("ui.panels.central-panel.stats"),
                            layout = wibox.layout.fixed.horizontal
                        },
                         require("ui.panels.central-panel.music-player"),
                        layout = wibox.layout.fixed.vertical,
                    },
                    margins = dpi(10),
                    widget = wibox.container.margin,
                },
                shape = helpers.ui.prrect(beautiful.border_radius * 2, true, true, false, false),
                bg = beautiful.wibar_bg,
                widget = wibox.container.background,
            },
            layout = wibox.layout.align.vertical,
        },
        bg = beautiful.widget_bg,
        shape = helpers.ui.rrect(beautiful.window_rounded and beautiful.border_radius or 0),
        widget = wibox.container.background,
    }

    s.central_panel = awful.popup({
        type = "popup",
        screen = s,
        bg = beautiful.transparent,
        ontop = true,
        visible = false,
        placement = function(w)
            awful.placement.bottom_left(w, {
                margins = { bottom = beautiful.wibar_height + 2 * beautiful.useless_gap, left = 2 * beautiful.useless_gap },
            })
        end,
        widget = widget_contents
    })

    --- Toggle container visibility
    awesome.connect_signal("central_panel::toggle", function(scr)
        if scr == s then
            s.central_panel.visible = not s.central_panel.visible
        end
    end)
end
