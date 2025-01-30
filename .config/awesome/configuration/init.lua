require(... .. ".autostart")
require(... .. ".desktop")
require(... .. ".keys")
require(... .. ".layout")
require(... .. ".ruled")
require(... .. ".tags")

local helpers = require("helpers")
local layouts = require(... .. ".keyboard")

helpers.keyboard.switch_to_layout(layouts[1])
