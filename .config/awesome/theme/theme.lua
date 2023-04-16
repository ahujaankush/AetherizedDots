local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local icon_path = os.getenv("HOME") .. "/.config/awesome/icons/"
local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/theme/layout/"
local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/theme/titlebar/"
local tip = titlebar_icon_path --alias to save time/space
local theme = {}

theme.scaling = 1
theme.opacity = 1

theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpaper/Wallpaper"
theme.player_img = os.getenv("HOME") .. "/Pictures/Wallpaper/Player"
theme.font_name = "Inter Medium"
theme.font = theme.font_name .. " 12"

theme.bg_dark = x.background
theme.bg_normal = x.background
theme.bg_focus = x.color0
theme.bg_urgent = x.color0
theme.bg_minimize = x.color0
theme.bg_systray = x.color0

theme.fg_normal = x.color7
theme.fg_focus = x.foreground
theme.fg_urgent = x.color1
theme.fg_minimize = x.color8

theme.useless_gap = dpi(10) * theme.scaling
theme.wibar_elements_gap = dpi(6) * theme.scaling
theme.screen_margin = dpi(6) * theme.scaling

theme.border_width = dpi(5) * theme.scaling
theme.border_color = x.background
theme.border_normal = x.background
theme.border_focus = x.background
theme.border_radius = dpi(10) * theme.scaling

theme.titlebars_enabled = true
theme.titlebar_size = dpi(35) * theme.scaling
theme.titlebar_title_enabled = true
theme.titlebar_font = theme.font_name .. " 10"
theme.titlebar_title_align = "center"
theme.titlebar_position = "top"
theme.titlebar_bg = x.background
theme.titlebar_fg_focus = x.color7
theme.titlebar_fg_normal = x.color7
theme.titlebar_fg = x.color7
theme.notification_position = "top_right"
theme.notification_border_width = dpi(0) * theme.scaling
theme.notification_border_radius = theme.border_radius
theme.notification_bg = x.background
theme.notification_fg = x.foreground
theme.notification_text_bg = x.color0
theme.notification_actions_bg = x.color8
theme.notification_height = dpi(140) * theme.scaling
theme.notification_width = dpi(320) * theme.scaling
theme.notification_min_height = dpi(140) * 0.66 * theme.scaling
theme.notification_min_width = dpi(320) * 0.66 * theme.scaling
theme.notification_image_size = theme.notification_height * 0.75 * theme.scaling
theme.notification_image_container_max_size = theme.notification_image_size * 1.25 * theme.scaling
theme.notification_image_container_max_size = theme.notification_image_size * 1.25 * theme.scaling
theme.notification_margin = dpi(16) * theme.scaling
theme.notification_opacity = theme.opacity
theme.notification_font = theme.font_name .. " 12"
theme.notification_title_font = theme.font_name .. " 13"
theme.notification_padding = theme.screen_margin * 2 * theme.scaling
theme.notification_spacing = theme.screen_margin * 4 * theme.scaling
theme.notification_osd_bg = x.background
theme.notification_osd_indicator_bg = x.color0
theme.notification_osd_fg = x.foreground
theme.notification_osd_opacity = theme.opacity
theme.clear_icon = icon_path .. "notif-center/clear.png"
theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.delete_icon = icon_path .. "notif-center/delete.png"
theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

theme.snap_shape = gears.shape.rectangle
theme.snap_bg = x.foreground
theme.snap_border_width = dpi(3) * theme.scaling

theme.tagnames = {
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
}

theme.separator_text = " - "
theme.separator_fg = x.color8

theme.wibar_position = "top"
theme.wibar_height = dpi(45) * theme.scaling
theme.wibar_fg = x.foreground
theme.wibar_bg = x.background
theme.wibar_opacity = theme.opacity
theme.wibar_border_color = x.color0
theme.wibar_border_width = dpi(0) * theme.scaling
theme.wibar_border_radius = dpi(0) * theme.scaling

theme.prefix_fg = x.color8

theme.systray_icon_spacing = dpi(10) * theme.scaling
theme.systray_icon_size = dpi(20) * theme.scaling
theme.systray_max_rows = 1

theme.prompt_font = theme.font_name .. " 11"

theme.hotkeys_bg = x.background
theme.hotkeys_fg = x.foreground
theme.hotkeys_border_width = dpi(2) * theme.scaling
theme.hotkeys_border_color = x.color5
theme.hotkeys_modifiers_fg = x.color7
theme.hotkeys_label_bg = x.color0
theme.hotkeys_label_fg = x.foreground
theme.hotkeys_font = theme.font

theme.tasklist_font = theme.font
theme.tasklist_disable_icon = false
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = x.background
theme.tasklist_fg_focus = x.foreground
theme.tasklist_bg_normal = x.background
theme.tasklist_fg_normal = x.foreground
theme.tasklist_bg_minimize = x.background
theme.tasklist_fg_minimize = x.color8

theme.tasklist_bg_urgent = x.background
theme.tasklist_fg_urgent = x.color3
theme.tasklist_spacing = dpi(10) * theme.scaling
theme.tasklist_align = "center"

theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = x.color4 .. "85"

theme.tasklist_shape_border_width_focus = 2
theme.tasklist_shape_border_color_focus = x.color4

theme.tasklist_shape_border_width_minimized = 2
theme.tasklist_shape_border_color_minimized = x.color2 .. "50"

theme.tasklist_shape_border_width_urgent = 2
theme.tasklist_shape_border_color_urgent = x.color1 .. "80"

-- Sidebar
-- (Sidebar items can be customized in sidebar.lua)
theme.sidebar_bg = x.background
theme.sidebar_fg = x.color15
theme.sidebar_opacity = 1
theme.sidebar_position = "left" -- left or right
theme.sidebar_width = dpi(350)
theme.sidebar_height = screen_height
theme.sidebar_x = 0
theme.sidebar_y = theme.wibar_height
theme.sidebar_height_multip = 1 -- this value is multiplied with the screen height
theme.sidebar_border_radius = dpi(0) --theme.border_radius
theme.dash_center_bg = x.background
theme.dash_center_fg = x.color15
theme.dash_center_opacity = theme.opacity
theme.dash_center_position = "left" -- left or right
theme.dash_center_width = dpi(525) * theme.scaling
theme.dash_center_border_radius = dpi(0) * theme.scaling --theme.border_radius

-- Dashboard
theme.dashboard_bg = x.color0 .. "44"
theme.dashboard_fg = x.color15
theme.dashboard_opacity = theme.opacity

theme.control_center_opacity = theme.opacity
theme.control_center_section_width = dpi(400)
theme.control_center_section_height = dpi(625)
theme.control_center_section_spacing = dpi(8)
theme.control_center_element_bg = x.color0
theme.control_center_element_spacing = dpi(8)
theme.control_center_border_width = dpi(15)

theme.app_drawer_opacity = theme.opacity

theme.exit_screen_bg = x.color0 .. "44"
theme.exit_screen_fg = x.color8
theme.exit_screen_font = theme.font_name .. " 20"
theme.exit_screen_icon_size = dpi(180) * theme.scaling

theme.lock_screen_bg = x.color0 .. "44"
theme.lock_screen_fg = x.color7

-- Prompt
theme.prompt_fg = x.color12

-- Text Taglist (default)
theme.taglist_font = theme.font_name .. " 9"
theme.taglist_bg_focus = colors.transparent
theme.taglist_fg_focus = x.foreground
theme.taglist_bg_occupied = colors.transparent
theme.taglist_fg_occupied = x.color8
theme.taglist_bg_empty = colors.transparent
theme.taglist_fg_empty = x.background
theme.taglist_bg_urgent = colors.transparent
theme.taglist_fg_urgent = x.color3
theme.taglist_disable_icon = true
theme.taglist_spacing = dpi(0) * theme.scaling

-- Variables set for theming the menu:
theme.menu_height = dpi(40) * theme.scaling
theme.menu_width = dpi(300) * theme.scaling
theme.menu_bg_normal = x.background
theme.menu_fg_normal = x.color7
theme.menu_bg_focus = x.color0
theme.menu_fg_focus = x.foreground
theme.menu_spacing = dpi(5) * theme.scaling
theme.menu_border_width = dpi(10) * theme.scaling
theme.menu_border_color = x.background
theme.menu_radius = theme.border_radius
theme.menu_opacity = theme.opacity
theme.menu_submenu_icon_font = "JetBrainsMono Nerd Font 8"
theme.menu_text_font = theme.font_name .. " 12"
theme.menu_icon_font = "JetBrainsMono Nerd Font 12"
theme.menu_submenu_icon = ""
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Titlebar buttons
-- Define the images to load
theme.titlebar_close_button_normal = tip .. "close_normal.svg"
theme.titlebar_close_button_focus = tip .. "close_focus.svg"
theme.titlebar_minimize_button_normal = tip .. "minimize_normal.svg"
theme.titlebar_minimize_button_focus = tip .. "minimize_focus.svg"
theme.titlebar_ontop_button_normal_inactive = tip .. "ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive = tip .. "ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = tip .. "ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active = tip .. "ontop_focus_active.svg"
theme.titlebar_sticky_button_normal_inactive = tip .. "sticky_normal_inactive.svg"
theme.titlebar_sticky_button_focus_inactive = tip .. "sticky_focus_inactive.svg"
theme.titlebar_sticky_button_normal_active = tip .. "sticky_normal_active.svg"
theme.titlebar_sticky_button_focus_active = tip .. "sticky_focus_active.svg"
theme.titlebar_floating_button_normal_inactive = tip .. "floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive = tip .. "floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = tip .. "floating_normal_active.svg"
theme.titlebar_floating_button_focus_active = tip .. "floating_focus_active.svg"
theme.titlebar_maximized_button_normal_inactive = tip .. "maximized_normal_inactive.svg"
theme.titlebar_maximized_button_focus_inactive = tip .. "maximized_focus_inactive.svg"
theme.titlebar_maximized_button_normal_active = tip .. "maximized_normal_active.svg"
theme.titlebar_maximized_button_focus_active = tip .. "maximized_focus_active.svg"
-- (hover)
theme.titlebar_close_button_normal_hover = tip .. "close_normal_hover.svg"
theme.titlebar_close_button_focus_hover = tip .. "close_focus_hover.svg"
theme.titlebar_minimize_button_normal_hover = tip .. "minimize_normal_hover.svg"
theme.titlebar_minimize_button_focus_hover = tip .. "minimize_focus_hover.svg"
theme.titlebar_ontop_button_normal_inactive_hover = tip .. "ontop_normal_inactive_hover.svg"
theme.titlebar_ontop_button_focus_inactive_hover = tip .. "ontop_focus_inactive_hover.svg"
theme.titlebar_ontop_button_normal_active_hover = tip .. "ontop_normal_active_hover.svg"
theme.titlebar_ontop_button_focus_active_hover = tip .. "ontop_focus_active_hover.svg"
theme.titlebar_sticky_button_normal_inactive_hover = tip .. "sticky_normal_inactive_hover.svg"
theme.titlebar_sticky_button_focus_inactive_hover = tip .. "sticky_focus_inactive_hover.svg"
theme.titlebar_sticky_button_normal_active_hover = tip .. "sticky_normal_active_hover.svg"
theme.titlebar_sticky_button_focus_active_hover = tip .. "sticky_focus_active_hover.svg"
theme.titlebar_floating_button_normal_inactive_hover = tip .. "floating_normal_inactive_hover.svg"
theme.titlebar_floating_button_focus_inactive_hover = tip .. "floating_focus_inactive_hover.svg"
theme.titlebar_floating_button_normal_active_hover = tip .. "floating_normal_active_hover.svg"
theme.titlebar_floating_button_focus_active_hover = tip .. "floating_focus_active_hover.svg"
theme.titlebar_maximized_button_normal_inactive_hover = tip .. "maximized_normal_inactive_hover.svg"
theme.titlebar_maximized_button_focus_inactive_hover = tip .. "maximized_focus_inactive_hover.svg"
theme.titlebar_maximized_button_normal_active_hover = tip .. "maximized_normal_active_hover.svg"
theme.titlebar_maximized_button_focus_active_hover = tip .. "maximized_focus_active_hover.svg"

-- You can use your own layout icons like this:
theme.layout_fairh = layout_icon_path .. "fairh.png"
theme.layout_fairv = layout_icon_path .. "fairv.png"
theme.layout_floating = layout_icon_path .. "floating.png"
theme.layout_magnifier = layout_icon_path .. "magnifier.png"
theme.layout_max = layout_icon_path .. "max.png"
theme.layout_fullscreen = layout_icon_path .. "fullscreen.png"
theme.layout_tilebottom = layout_icon_path .. "tilebottom.png"
theme.layout_tileleft = layout_icon_path .. "tileleft.png"
theme.layout_tile = layout_icon_path .. "tile.png"
theme.layout_tiletop = layout_icon_path .. "tiletop.png"
theme.layout_spiral = layout_icon_path .. "spiral.png"
theme.layout_dwindle = layout_icon_path .. "dwindle.png"
theme.layout_cornernw = layout_icon_path .. "cornernw.png"
theme.layout_cornerne = layout_icon_path .. "cornerne.png"
theme.layout_cornersw = layout_icon_path .. "cornersw.png"
theme.layout_cornerse = layout_icon_path .. "cornerse.png"
theme.layout_mstab = layout_icon_path .. "mstab.png"
theme.layout_centered = layout_icon_path .. "centered.png"
theme.layout_equalarea = layout_icon_path .. "equalarea.png"
theme.layout_deck = layout_icon_path .. "deck.png"
theme.layout_machi = layout_icon_path .. "machi.png"

-- Recolor layout icons
-- theme = theme_assets.recolor_layout(theme, x.color1)

-- Noodle widgets customization --
-- Desktop mode widget variables
-- Symbols     
-- theme.desktop_mode_color_floating = x.color4
-- theme.desktop_mode_color_tile = x.color3
-- theme.desktop_mode_color_max = x.color1
-- theme.desktop_mode_text_floating = "f"
-- theme.desktop_mode_text_tile = "t"
-- theme.desktop_mode_text_max = "m"

theme.layoutlist_fg_normal = x.foreground
theme.layoutlist_bg_normal = x.color0
theme.layoutlist_fg_selected = x.foreground
theme.layoutlist_bg_selected = x.color8
theme.layoutlist_shape = helpers.rrect(theme.border_radius)
theme.layoutlist_shape_selected = helpers.rrect(theme.border_radius)
-- Minimal tasklist widget variables
theme.minimal_tasklist_visible_clients_color = x.color4
theme.minimal_tasklist_visible_clients_text = ""
theme.minimal_tasklist_hidden_clients_color = x.color7
theme.minimal_tasklist_hidden_clients_text = ""

-- Volume bar
theme.volume_bar_active_color = x.color4
theme.volume_bar_active_background_color = x.color0
theme.volume_bar_muted_color = x.color8
theme.volume_bar_muted_background_color = x.color0

-- Temperature bar
theme.temperature_bar_active_color = x.color1
theme.temperature_bar_background_color = x.color0

-- Battery bar
theme.battery_bar_active_color = x.color6
theme.battery_bar_background_color = x.color0

-- CPU bar
theme.cpu_bar_active_color = x.color2
theme.cpu_bar_background_color = x.color0

-- RAM bar
theme.ram_bar_active_color = x.color5
theme.ram_bar_background_color = x.color0

-- Brightness bar
theme.brightness_bar_active_color = x.color3
theme.brightness_bar_background_color = x.color0

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = os.getenv("HOME") .. "/.icons/oomox-aesthetic-dark/"

-- Task Preview
theme.task_preview_widget_border_radius = 0 * theme.scaling --theme.border_radius -- Border radius of the widget (With AA)
theme.task_preview_widget_bg = x.background -- The bg color of the widget
theme.task_preview_widget_border_color = theme.border_color -- The border color of the widget
theme.task_preview_widget_border_width = 1 * theme.scaling -- The border width of the widget
theme.task_preview_widget_margin = dpi(20) * theme.scaling -- The margin of the widget
theme.bling_preview_bottom_margin = dpi(60) * theme.scaling

theme.fade_duration = 250

-- Tag Preview
theme.tag_preview_widget_border_radius = 0 * theme.scaling --theme.border_radius        -- Border radius of the widget (With AA)
theme.tag_preview_client_border_radius = theme.border_radius -- Border radius of each client in the widget (With AA)
theme.tag_preview_client_opacity = theme.opacity -- Opacity of each client
theme.tag_preview_client_bg = x.background -- The bg color of each client
theme.tag_preview_client_border_color = theme.border_color -- The border color of each client
theme.tag_preview_client_border_width = theme.border_width -- The border width of each client
theme.tag_preview_widget_bg = x.background -- The bg color of the widget
theme.tag_preview_widget_border_color = theme.border_color -- The border color of the widget
theme.tag_preview_widget_border_width = theme.border_width -- The border width of the widget
theme.tag_preview_widget_margin = dpi(20) * theme.scaling -- The margin of the widget

-- window switcher
theme.window_switcher_widget_bg = x.background .. "CC" -- The bg color of the widget
theme.window_switcher_widget_border_width = dpi(5) * theme.scaling -- The border width of the widget
theme.window_switcher_widget_border_radius = 0 * theme.scaling --theme.border_radius -- The border radius of the widget
theme.window_switcher_widget_border_color = x.background -- The border color of the widget
theme.window_switcher_clients_spacing = dpi(15) * theme.scaling -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = dpi(5) * theme.scaling -- The space between client icon and text
theme.window_switcher_client_width = dpi(250) * theme.scaling -- The width of one client widget
theme.window_switcher_client_height = dpi(350) * theme.scaling -- The height of one client widget
theme.window_switcher_client_margins = dpi(20) * theme.scaling -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = dpi(10) * theme.scaling -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = true -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = dpi(10) * theme.scaling -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center" -- How to vertically align one clients title
theme.window_switcher_name_forced_width = dpi(200) * theme.scaling -- The width of one title
theme.window_switcher_name_font = theme.font_name .. " 11" -- The font of all titles
theme.window_switcher_name_normal_color = x.foreground -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = x.color5 -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center" -- How to vertially align the one icon
theme.window_switcher_icon_width = dpi(50) * theme.scaling -- Thw width of one icon

-- tabbed
theme.tabbed_spawn_in_tab = true -- whether a new client should spawn into the focused tabbing container

-- tabbar general
theme.tabbar_ontop = false
theme.tabbar_radius = 0 * theme.scaling --theme.border_radius                -- border radius of the tabbar
theme.tabbar_style = "modern" -- style of the tabbar ("default", "boxes" or "modern")
theme.tabbar_font = theme.font -- font of the tabbar
theme.tabbar_size = dpi(35) -- size of the tabbar
theme.tabbar_position = "bottom" -- position of the tabbar
theme.tabbar_bg_normal = x.background -- background color of the focused client on the tabbar
theme.tabbar_fg_normal = x.foreground -- foreground color of the focused client on the tabbar
theme.tabbar_bg_focus = x.color0 -- background color of unfocused clients on the tabbar
theme.tabbar_fg_focus = x.foreground -- foreground color of unfocused clients on the tabbar
theme.tabbar_bg_focus_inactive = nil -- background color of the focused client on the tabbar when inactive
theme.tabbar_fg_focus_inactive = nil -- foreground color of the focused client on the tabbar when inactive
theme.tabbar_bg_normal_inactive = nil -- background color of unfocused clients on the tabbar when inactive
theme.tabbar_fg_normal_inactive = nil -- foreground color of unfocused clients on the tabbar when inactive
theme.tabbar_disable = false -- disable the tab bar entirely

-- mstab
theme.mstab_bar_disable = false -- disable the tabbar
theme.mstab_bar_ontop = true -- whether you want to allow the bar to be ontop of clients
theme.mstab_dont_resize_slaves = false -- whether the tabbed stack windows should be smaller than the
-- currently focused stack window (set it to true if you use
-- transparent terminals. False if you use shadows on solid ones
theme.mstab_bar_padding = "default" -- how much padding there should be between clients and your tabbar
-- by default it will adjust based on your useless gaps.
-- If you want a custom value. Set it to the number of pixels (int)
theme.mstab_border_radius = theme.border_radius -- border radius of the tabbar
theme.mstab_bar_height = dpi(35) * theme.scaling -- height of the tabbar
theme.mstab_tabbar_position = "bottom" -- position of the tabbar (mstab currently does not support left,right)
theme.mstab_tabbar_style = "modern" -- style of the tabbar ("default", "boxes" or "modern")
-- defaults to the tabbar_style so only change if you want a
-- different style for mstab and tabbed

-- the following variables are currently only for the "modern" tabbar style
theme.tabbar_color_close = x.color1 -- chnges the color of the close button
theme.tabbar_color_min = x.color3 -- chnges the color of the minimize button
theme.tabbar_color_float = x.color5 -- chnges the color of the float button

theme.flash_focus_start_opacity = 0.7 -- the starting opacity
theme.flash_focus_step = 0.01 -- the step of animation

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
