local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
    awful.spawn("bash " .. config_dir .. "configuration/display.sh", false)
    --- Music Server
    helpers.run.run_once_pgrep("mpd")
    helpers.run.run_once_pgrep("mpDris2")
    helpers.run.run_once_pgrep("XDG_MENU_PREFIX=arch- kbuildsycoca6") -- archlinux-xdg-menu
    helpers.run.run_once_pgrep("picom")                               -- archlinux-xdg-menu
    helpers.run.run_once_pgrep("conky")
    --- Polkit Agent
    helpers.run.run_once_ps(
        "polkit-gnome-authentication-agent-1",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    )
    --- Other stuff
    helpers.run.run_once_grep("blueman-applet")
    helpers.run.run_once_grep("nm-applet")
end

autostart_apps()
