return {
  {
    "nvim-neorg/neorg",
    cmd = { "Neorg" },
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    config = function()
      require "plugins.configs.notes.neorg"
    end,
  },
}
