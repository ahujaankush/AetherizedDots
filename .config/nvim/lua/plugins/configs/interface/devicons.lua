local devicons = require "nvim-web-devicons"
dofile(vim.g.base46_cache .. "devicons")
local options = require("core.utils").load_config().ui.icons
devicons.setup { override = options.devicons }
