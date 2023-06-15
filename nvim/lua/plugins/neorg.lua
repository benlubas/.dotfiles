return {
  "nvim-neorg/neorg",
  -- this doesn't work on m1 macs
  -- run = ":Neorg sync-parsers", -- This is the important bit!
  build = ":Neorg sync-parsers",
  keys = {
    { "<leader>n", ":Neorg workspace work<CR>", desc = "take me to my work notes" },
    -- TOOD: Keymap for :Neorg return? using local leader and only defined in norg files
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {
        config = {
          icon_preset = "diamond",
        }
      },
      ["core.dirman"] = {
        config = {
          workspaces = {
            work = "~/notes/work",
          },
        },
      },
    },
  },
}
