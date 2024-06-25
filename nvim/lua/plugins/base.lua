return {
  {
    "mrshmllow/open-handlers.nvim",
    config = function()
      local oh = require("open-handlers")

      oh.setup({
        -- In order, each handler is tried.
        -- The first handler to successfully open will be used.
        handlers = {
          oh.gh_repo,
          oh.issue,  -- A builtin which handles github and gitlab issues
          oh.commit, -- A builtin which handles git commits
          oh.native, -- Default native handler. Should always be last
        },
      })
    end,
  },
  {
    "benlubas/wrapping-paper.nvim",
    -- dev = true,
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
