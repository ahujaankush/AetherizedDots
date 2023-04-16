return {
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    -- ["core.norg.esupports.indent"] = {
    -- config = {
    --     indents = {
    --         ["_line_break"] = {
    --             indent = function(_, node)
    --                 if node:parent():type() == "ranged_tag_content" then
    --                     return 4
    --                 end
    --             end,
    --         },
    --     },
    -- },
    -- },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = "auto",
      },
    },

    ["core.integrations.telescope"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.norg.concealer"] = {
      config = {
        -- markup_preset = "dimmed",
        markup_preset = "conceal",
        icon_preset = "diamond",
        -- icon_preset = "varied",
        icons = {
          marker = {
            enabled = true,
            icon = " ",
          },
          todo = {
            enable = true,
            pending = {
              -- icon = ""
              icon = "",
            },
            uncertain = {
              icon = "?",
            },
            urgent = {
              icon = "",
            },
            on_hold = {
              icon = "",
            },
            cancelled = {
              icon = "",
            },
          },
          heading = {
            enabled = true,
            level_1 = {
              icon = "◈",
            },

            level_2 = {
              icon = "  ◇",
            },

            level_3 = {
              icon = "    ◆",
            },
            level_4 = {
              icon = "      ❖",
            },
            level_5 = {
              icon = "          ⟡",
            },
            level_6 = {
              icon = "            ⋄",
            },
          },
        },
      },
    },
    ["core.presenter"] = {
      config = {
        zen_mode = "truezen",
        slide_count = {
          enable = true,
          position = "top",
          count_format = "[%d/%d]",
        },
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = ",",
        hook = function(keybinds)
          keybinds.unmap("all", "n", "<c-s>")
        end,
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = os.getenv "HOME" .. "/Documents/Notes",
        },
      },
    },
    ["core.norg.qol.toc"] = {},
    ["core.norg.qol.todo_items"] = {},
    ["core.norg.journal"] = {
      config = {
        workspace = "gtd",
        journal_folder = "notes/journal",
        strategy = "nested",
      },
    },
    ["core.export"] = {},
    ["core.export.markdown"] = {
      config = {
        extensions = "all",
      },
    },
  },
}
