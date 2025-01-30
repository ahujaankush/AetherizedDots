local awful      = require("awful")
local gears      = require("gears")
local wibox      = require("wibox")
local beautiful  = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi        = xresources.apply_dpi
local helpers    = require("helpers")
local widgets    = require("ui.widgets")
local wbutton    = require("ui.widgets.button")
local animation  = require("modules.animation")
local apps       = require("configuration.apps")
local gcolor     = require("gears.color")

--- Modern Top Panel
--- ~~~~~~~~~~~~~~~~~~~

return function(s)
    --- Menu Button
    --- ~~~~~~~~~~~~~~~~~

    local launcher = function()
        local icon = wibox.widget({
            widget = wibox.widget.imagebox,
            image = beautiful.distro,
            resize = true,
        })

        local widget = wibox.widget({
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5)
            },
            wbutton.elevated.normal({
                child = icon,
                normal_bg = beautiful.widget_bg,
                hover_bg = beautiful.one_bg,
                paddings = dpi(5),
                margins = {
                    top = 0,
                    left = 0,
                    right = 0,
                    bottom = 0
                },
                on_release = function()
                    awesome.emit_signal("central_panel::toggle", s)
                end,
            })
        })

        return widget
    end

    --- Animated tag list
    --- ~~~~~~~~~~~~~~~~~

    --- Taglist buttons
    local modkey = "Mod4"
    local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t)
            t:view_only()
        end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end)
    )

    local function taglist(s)
        local taglist = awful.widget.taglist({
            screen = s,
            filter = awful.widget.taglist.filter.all,
            layout = { layout = wibox.layout.fixed.horizontal },
            widget_template = {
                widget = wibox.container.margin,
                forced_width = dpi(40),
                forced_height = dpi(40),
                create_callback = function(self, c3, _)
                    local indicator = wibox.widget({
                        widget = wibox.container.place,
                        valign = "center",
                        {
                            widget = wibox.container.background,
                            forced_height = dpi(8),
                            shape = gears.shape.rounded_bar,
                        },
                    })

                    self.indicator_animation = animation:new({
                        duration = 0.125,
                        easing = animation.easing.linear,
                        update = function(self, pos)
                            indicator.children[1].forced_width = pos
                        end,
                    })

                    self:set_widget(indicator)

                    if c3.selected then
                        self.widget.children[1].bg = beautiful.accent
                        self.indicator_animation:set(dpi(30))
                    elseif #c3:clients() == 0 then
                        self.widget.children[1].bg = beautiful.light_grey
                        self.indicator_animation:set(dpi(12))
                    else
                        self.widget.children[1].bg = beautiful.color15
                        self.indicator_animation:set(dpi(18))
                    end

                    --- Tag preview
                    self:connect_signal("mouse::enter", function()
                        if #c3:clients() > 0 then
                            awesome.emit_signal("bling::tag_preview::update", c3)
                            awesome.emit_signal("bling::tag_preview::visibility", s, true)
                        end
                    end)

                    self:connect_signal("mouse::leave", function()
                        awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    end)
                end,
                update_callback = function(self, c3, _)
                    if c3.selected then
                        self.widget.children[1].bg = beautiful.accent
                        self.indicator_animation:set(dpi(30))
                    elseif #c3:clients() == 0 then
                        self.widget.children[1].bg = beautiful.light_grey
                        self.indicator_animation:set(dpi(12))
                    else
                        self.widget.children[1].bg = beautiful.color15
                        self.indicator_animation:set(dpi(18))
                    end
                end,
            },
            buttons = taglist_buttons,
        })

        local widget =
            wibox.widget(
                {
                    widgets.button.elevated.state({
                        normal_bg = beautiful.widget_bg,
                        child = taglist,
                    }),
                    margins = {
                        top = dpi(5),
                        bottom = dpi(5)
                    },
                    widget = wibox.container.margin
                }
            )
        return widget
    end

    local tasklist = require("ui.panels.top-panel.tasklist")

    --- Keyboard
    --- ~~~~~~~
    local keyboard = require("ui.panels.top-panel.keyboard")

    --- Power & Nvidia
    --- ~~~~~~~
    local function power()
    end

    --- Systemtray
    --- ~~~~~~~
    local systray = require("ui.panels.top-panel.systray")


    --- Volume
    --- ~~~~~~~
    local volume = require("ui.panels.top-panel.volume")


    --- Microphone
    --- ~~~~~~~
    local mic = require("ui.panels.top-panel.microphone")


    --- Brightness
    --- ~~~~~~~
    local brightness = require("ui.panels.top-panel.brightness")


    --- Battery
    --- ~~~~~~~
    local battery = require("ui.panels.top-panel.battery")

    --- Notif panel
    --- ~~~~~~~~~~~
    local function notif_panel()
        local icon = wibox.widget({
            markup = helpers.ui.colorize_text("", beautiful.fg_normal),
            align = "center",
            valign = "center",
            font = beautiful.icon_font .. "Round 16",
            widget = wibox.widget.textbox,
        })

        local widget = wibox.widget({
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5)
            },
            wbutton.elevated.normal({
                child = icon,
                normal_bg = beautiful.widget_bg,
                hover_bg = beautiful.one_bg,
                paddings = dpi(4),
                margins = {
                    top = 0,
                    left = 0,
                    right = 0,
                    bottom = 0
                },
                on_release = function()
                    awesome.emit_signal("notification_panel::toggle", s)
                end,
            })
        })
        return widget
    end

    --- Clock
    --- ~~~~~~~~~
    local clock = function()
        local icon = require("ui.panels.top-panel.clock")()

        local widget = wibox.widget({
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5)
            },
            wbutton.elevated.normal({
                child = icon,
                normal_bg = beautiful.widget_bg,
                hover_bg = beautiful.one_bg,
                paddings = dpi(5),
                margins = {
                    top = 0,
                    left = 0,
                    right = 0,
                    bottom = 0
                },
                on_release = function(self)
                    awful.spawn(apps.default.calendar, false)
                end,
            })
        })

        return widget
    end

    --- Layoutbox
    --- ~~~~~~~~~
    local function layoutbox()
        local layoutbox_buttons = gears.table.join(
        --- Left click
            awful.button({}, 1, function(c)
                awful.layout.inc(1)
            end),

            --- Right click
            awful.button({}, 3, function(c)
                awful.layout.inc(-1)
            end),

            --- Scrolling
            awful.button({}, 4, function()
                awful.layout.inc(-1)
            end),
            awful.button({}, 5, function()
                awful.layout.inc(1)
            end)
        )

        s.mylayoutbox = awful.widget.layoutbox()
        s.mylayoutbox:buttons(layoutbox_buttons)

        local widget = wibox.widget({
            widget = wibox.container.margin,
            margins = {
                top = dpi(5),
                bottom = dpi(5)
            },
            wbutton.elevated.state({
                child = s.mylayoutbox,
                normal_bg = beautiful.widget_bg,
                hover_bg = beautiful.one_bg,
                paddings = dpi(5),
                margins = {
                    top = 0,
                    left = 0,
                    right = 0,
                    bottom = 0
                },

            })
        })

        return widget
    end

    --- Create the top_panel
    --- ~~~~~~~~~~~~~~~~~~~~~~~
    s.top_panel = awful.wibar({
        screen = s,
        maximum_height = beautiful.wibar_height,
        minimum_width = s.geometry.width,
        maximum_width = s.geometry.width,
        placement = function(c)
            awful.placement.top(c)
        end,
        widget = {
            {
                layout = wibox.layout.align.horizontal,
                expand = "none",
                {
                    launcher(),
                    layoutbox(),
                    taglist(s),
                    tasklist(s),
                    spacing = dpi(5),
                    layout = wibox.layout.fixed.horizontal,
                },
                clock(),
                {
                    battery(),
                    systray(s),
                    mic(),
                    volume(),
                    brightness(),
                    keyboard(),
                    notif_panel(),
                    spacing = dpi(5),
                    layout = wibox.layout.fixed.horizontal,
                },
            },
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin,
        },
    })
end
