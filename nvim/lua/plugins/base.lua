return {
  { "benlubas/auto-save.nvim", cond = not MarkdownMode() },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", ":UndotreeToggle<CR>:UndotreeFocus<CR>", desc = "toggle undotree", silent = true },
    },
  },
  {
    "benlubas/wrapping-paper.nvim",
    keys = { {
      "gww",
      function() require("wrapping-paper").wrap_line() end,
      desc = "wrap current line",
    } },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      surrounds = {
        ["l"] = {
          add = function()
            local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            local clipboard = vim.fn.getreg("+")
            if ft == "norg" then
              return { { ("{%s}["):format(clipboard) }, { "]" } }
            end
            -- default to markdown-style link
            return { { "[" }, { "](" .. clipboard .. ")" } }
          end,
          find = function()
            local config = require("nvim-surround.config")
            local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            if ft == "norg" then
              return config.get_selection({ node = "link" })
            end
            return config.get_selection({ node = "inline_link" })
          end,
          -- TODO: add support for norg links
          delete = "(%[)().-(%]%(.-%))()",
        },
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
}
