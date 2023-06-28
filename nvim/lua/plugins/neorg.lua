return {
  "nvim-neorg/neorg",
  -- this doesn't work on m1 macs
  build = ":Neorg sync-parsers",
  lazy = false,
  keys = {
    { "<leader>ni", ":Neorg index<CR>", desc = "Neorg Index", silent = true },
    { "<leader>nsi", ":e ~/notes/school/index.norg<CR>", desc = "Neorg School Index", silent = true },
    { "<leader>nwi", ":e ~/notes/work/index.norg<CR>", desc = "Neorg Work Index", silent = true },
    { "<leader>nti", ":e ~/notes/tools/index.norg<CR>", desc = "Neorg Tools Index", silent = true },
    { "<leader>nww", ":e ~/notes/work/wiki/index.norg<CR>", desc = "Neorg Work Wiki", silent = true },
    { "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>", desc = "New Note", silent = true },
    { "<leader>jt", ":Neorg journal today<CR>", desc = "Journal Today", silent = true },
    { "<leader>jy", ":Neorg journal yesterday<CR>", desc = "Journal Yesterday", silent = true },
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            -- Map \c to edit the code block in another buffer.
            keybinds.remap_event("norg", "n", "<localleader>c", "core.looking-glass.magnify-code-block")
            keybinds.map("norg", "n", "<localleader>r", ":Neorg return<CR>")
          end,
        },
      },
      ["core.concealer"] = {
        config = {
          icon_preset = "diamond",
          icons = {
            todo = {
              undone = {
                icon = " ",
              },
            },
          },
        },
      },
      ["core.journal"] = {
        config = {
          -- NOTE: I'm using the journal for work only. You can have multiple journals.
          -- But I'm just planning to switch this config option when I'm no longer working if
          -- I still need a journal.
          workspace = "work",
        },
      },
      ["core.summary"] = {},
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            work = "~/notes/work",
            school = "~/notes/school",
            general_notes = "~/notes/general_notes",
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
    },
  },
}
