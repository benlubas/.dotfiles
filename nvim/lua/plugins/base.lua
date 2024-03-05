return {
  {
    "benlubas/wrapping-paper.nvim",
    -- dev = true,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = { {
      "gww",
      function()
        require("wrapping-paper").wrap_line()
      end,
      desc = "fake wrap current line",
    } },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      surrounds = {
        ["l"] = {
          add = function()
            local clipboard = vim.fn.getreg("+")
            return { { "[" }, { "](" .. clipboard .. ")" } }
          end,
          find = function()
            local config = require("nvim-surround.config")
            return config.get_selection({ node = "inline_link" })
          end,
          delete = "(%[)().-(%]%(.-%))()",
        },
      },
    },
  },
  { "benlubas/auto-save.nvim", cond = not MarkdownMode() },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        ":UndotreeToggle<CR>:UndotreeFocus<CR>",
        desc = "toggle undotree",
        silent = true,
      },
    },
  },
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 2, -- MiB (2 MiB is just over 2MB)
      features = {
        "indent_blankline",
        "lsp",
        "treesitter",
        "syntax",
        -- "matchparen", -- I'm not sure about this having a large impact on perf, and it stays disabled, so I'm going to comment it out
        "vimopts",
        "filetype",
        {
          name = "neoscroll",
          disable = function()
            vim.api.nvim_buf_set_var(0, "disable_neoscroll", true)
          end,
        },
      },
    },
  },
  -- {
  --   "max397574/better-escape.nvim",
  --   opts = {
  --     mapping = { "jk", "kj" }, -- why not both
  --   },
  -- },
}
