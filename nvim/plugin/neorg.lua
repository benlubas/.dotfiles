require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          refile = "~/github/notes/refile", -- not really sure what this does agian...
        }
      }
    },
    ["core.norg.concealer"] = {
      config = {
        width = "content", -- for code blocks
        icon_preset = "diamond",
        icons = {
          todo = {
            enabled = true,
            pending = {
              icon = "ﲊ",
            },
            undone = {
              icon = " ", -- I just want some white space.
              highlight = "Text",
            },
            urgent = {
              icon = "",
            },
            on_hold = {
              icon = "",
            },
            uncertain = {
              icon = ""
            },
            cancelled = {
              icon = ""
            },
          },
        },
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    },
    ["core.norg.qol.toc"] = {},
  }
}
