--- ░▀█▀░█░█░█▀▀░█▄█░█▀▀
--- ░░█░░█▀█░█▀▀░█░█░█▀▀
--- ░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

local gears         = require("gears")
local gfs           = require("gears.filesystem")
local themes_path   = gfs.get_themes_dir()
local theme         = dofile(themes_path .. "default/theme.lua")
local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
local helpers       = require("helpers")
local icons         = require("icons")

--- ░█▀▀░█▀█░█▀█░▀█▀░█▀▀
--- ░█▀▀░█░█░█░█░░█░░▀▀█
--- ░▀░░░▀▀▀░▀░▀░░▀░░▀▀▀

--- Ui Fonts
theme.font_name     = "Inter "
theme.font          = theme.font_name .. "Medium 10"

--- Icon Fonts
theme.icon_font     = "Material Icons "

--- ░█▀▀░█▀█░█░░░█▀█░█▀▄░█▀▀
--- ░█░░░█░█░█░░░█░█░█▀▄░▀▀█
--- ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

--- Special
theme.white         = "#edeff0"
theme.darker_black  = "#0A0C10"
theme.black         = "#101317"
theme.lighter_black = "#161A1D"
theme.one_bg        = "#252525"
theme.one_bg2       = "#2a2a2a"
theme.one_bg3       = "#353535"
theme.grey          = "#3a3a3a"
theme.grey_fg       = "#454545"
theme.grey_fg2      = "#4a4a4a"
theme.light_grey    = "#555555"

theme.transparent   = "#00000000"

--- Black
theme.color0        = "#171b21"
theme.color8        = "#2d373e"

--- Red
theme.color1        = "#f7467b"
theme.color9        = "#ff62c1"

--- Green
theme.color2        = "#00ffb1"
theme.color10       = "#1addb0"

--- Yellow
theme.color3        = "#f99e44"
theme.color11       = "#ffc857"

--- Blue
theme.color4        = "#53befc"
theme.color12       = "#2798e4"

--- Magenta
theme.color5        = "#B467F9"
theme.color13       = "#9554ff"

--- Cyan
theme.color6        = "#2bfcfc"
theme.color14       = "#2BCAFC"

--- White
theme.color7        = "#f2f4f5"
theme.color15       = "#a1a1a1"

--- Background Colors
theme.bg_normal     = theme.black
theme.bg_focus      = theme.black
theme.bg_urgent     = theme.black
theme.bg_minimize   = theme.black

--- Foreground Colors
theme.fg_normal     = theme.white
theme.fg_focus      = theme.accent
theme.fg_urgent     = theme.color1
theme.fg_minimize   = theme.color0

--- Accent colors
function theme.random_accent_color()
    local accents = {
        theme.color1,
        theme.color2,
        theme.color3,
        theme.color4,
        theme.color5,
        theme.color6,
    }

    local i = math.random(1, #accents)
    return accents[i]
end

theme.accent = theme.white

--- UI events
theme.leave_event = theme.transparent
theme.enter_event = "#ffffff" .. "10"
theme.press_event = "#ffffff" .. "15"
theme.release_event = "#ffffff" .. "10"

--- Widgets
theme.widget_bg = theme.lighter_black

--- Titlebars
theme.titlebar_enabled = true
theme.titlebar_bg = theme.darker_black
theme.titlebar_fg = theme.white

--- Wibar
theme.wibar_bg = theme.darker_black .. "AA"
theme.wibar_height = dpi(45)

--- Music
theme.music_bg = theme.black
theme.music_bg_accent = theme.darker_black
theme.music_accent = theme.lighter_black

--- ░█░█░▀█▀░░░█▀▀░█░░░█▀▀░█▄█░█▀▀░█▀█░▀█▀░█▀▀
--- ░█░█░░█░░░░█▀▀░█░░░█▀▀░█░█░█▀▀░█░█░░█░░▀▀█
--- ░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀

--- Wallpapers
theme.wallpaper = gears.surface.load_uncached(gfs.get_configuration_dir() .. "Wallpaper.png")

--- Image Assets
theme.pfp = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/pfp.png")
theme.distro = gears.surface.load_uncached(gfs.get_configuration_dir() .. "icons/distro/arch.svg")
theme.music = gears.surface.load_uncached(gfs.get_configuration_dir() .. "theme/assets/music.png")

--- Layout
--- You can use your own layout icons like this:
theme.layout_floating = icons.floating
theme.layout_max = icons.max
theme.layout_tile = icons.tile
theme.layout_dwindle = icons.dwindle
theme.layout_centered = icons.centered
theme.layout_mstab = icons.mstab
theme.layout_equalarea = icons.equalarea
theme.layout_machi = icons.machi

--- Icon Theme
--- Define the icon theme for application icons. If not set then the icons
--- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "WhiteSur-dark"

--- Borders
theme.border_width = 0
theme.oof_border_width = 0
theme.border_color_marked = theme.titlebar_bg
theme.border_color_active = theme.titlebar_bg
theme.border_color_normal = theme.titlebar_bg
theme.border_color_new = theme.titlebar_bg
theme.border_color_urgent = theme.titlebar_bg
theme.border_color_floating = theme.titlebar_bg
theme.border_color_maximized = theme.titlebar_bg
theme.border_color_fullscreen = theme.titlebar_bg

--- Corner Radius
theme.window_rounded = false
theme.border_radius = dpi(5)

--- Edge snap
theme.snap_bg = theme.color8
theme.snap_shape = helpers.ui.rrect(0)

--- Main Menu
theme.main_menu_bg = theme.lighter_black

--- Tooltip
theme.tooltip_bg = theme.lighter_black
theme.tooltip_fg = theme.white
theme.tooltip_font = theme.font_name .. "Regular 10"

--- Hotkeys Pop Up
theme.hotkeys_bg = theme.black
theme.hotkeys_fg = theme.white
theme.hotkeys_modifiers_fg = theme.white
theme.hotkeys_font = theme.font_name .. "Medium 12"
theme.hotkeys_description_font = theme.font_name .. "Regular 10"
theme.hotkeys_shape = helpers.ui.rrect(theme.border_radius)
theme.hotkeys_group_margin = dpi(50)

--- Tag list
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

--- Tag preview
theme.tag_preview_widget_margin = dpi(10)
theme.tag_preview_widget_border_radius = theme.window_rounded and theme.border_radius or 0
theme.tag_preview_client_border_radius = theme.border_radius / 2
theme.tag_preview_client_opacity = 1
theme.tag_preview_client_bg = theme.wibar_bg
theme.tag_preview_client_border_color = theme.wibar_bg
theme.tag_preview_client_border_width = dpi(2)
theme.tag_preview_widget_bg = theme.wibar_bg
theme.tag_preview_widget_border_color = theme.wibar_bg
theme.tag_preview_widget_border_width = dpi(3)

--- Task preview
theme.task_preview_widget_margin = dpi(10)
theme.task_preview_widget_border_radius = theme.window_rounded and theme.border_radius or 0
theme.task_preview_widget_bg = theme.wibar_bg
theme.task_preview_widget_border_color = theme.wibar_bg
theme.task_preview_widget_border_width = dpi(3)

--- Layout List
theme.layoutlist_shape_selected = helpers.ui.rrect(theme.border_radius)
theme.layoutlist_bg_selected = theme.widget_bg

--- Gaps
theme.useless_gap = dpi(10)

--- Systray
theme.systray_icon_size = dpi(27)
theme.systray_icon_spacing = dpi(5)
theme.bg_systray = theme.widget_bg .. "00"
--- theme.systray_max_rows = 2

--- Tabs
theme.mstab_bar_height = dpi(60)
theme.mstab_bar_padding = dpi(0)
theme.mstab_border_radius = dpi(6)
theme.mstab_bar_disable = true
theme.tabbar_disable = true
theme.tabbar_style = "modern"
theme.tabbar_bg_focus = theme.black
theme.tabbar_bg_normal = theme.color0
theme.tabbar_fg_focus = theme.color0
theme.tabbar_fg_normal = theme.color15
theme.tabbar_position = "bottom"
theme.tabbar_AA_radius = 0
theme.tabbar_size = 0
theme.mstab_bar_ontop = true

--- Notifications
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.black
theme.notification_bg_alt = theme.lighter_black

--- Notif center
theme.notif_center_notifs_bg = theme.one_bg2
theme.notif_center_notifs_bg_alt = theme.one_bg3

--- Swallowing
theme.dont_swallow_classname_list = {
    "firefox",
    "gimp",
    "Google-chrome",
    "Thunar",
}

--- Layout Machi
theme.machi_switcher_border_color = theme.lighter_black
theme.machi_switcher_border_opacity = 0.25
theme.machi_editor_border_color = theme.lighter_black
theme.machi_editor_border_opacity = 0.25
theme.machi_editor_active_opacity = 0.25

return theme
