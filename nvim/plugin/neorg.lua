require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          refile = "~/github/notes/refile",
        }
      }
    },
    ["core.norg.concealer"] = {
      config = {
        width = "content",
        icon_preset = "diamond",
      }
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp"
      }
    },
    ["core.norg.qol.toc"] = {},
  }
}
