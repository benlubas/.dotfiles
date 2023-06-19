return {
  "nvim-neorg/neorg",
  -- this doesn't work on m1 macs
  -- run = ":Neorg sync-parsers", -- This is the important bit!
  build = ":Neorg sync-parsers",
  lazy = false,
  keys = {
    { "<leader>n", ":Neorg index<CR>", desc = "go to notes" },
    -- TOOD: Keymap for :Neorg return? using local leader and only defined in norg files
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            -- Map \c to edit the code block in another buffer.
            keybinds.remap_event("norg", "n", "<localleader>c", "core.looking-glass.magnify-code-block")
          end,
        },
      },
      ["core.concealer"] = {
        config = {
          icon_preset = "diamond",
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
