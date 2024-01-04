-- All of the visual changes that I'm running. This includes, moonfly theme, neoscroll,
-- which-key, devicons, indent_blankline, lualine, and status col

-- start screen is alpha nvim and has it's own file

return {
  {
    "bluz71/vim-moonfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyTransparent = true
      vim.g.moonflyItalics = false
      vim.g.moonflyUnderlineMatchParen = true
      vim.g.moonflyVirtualTextColor = true

      vim.cmd.syntax("enable")
      vim.cmd.colorscheme("moonfly")

      vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 238, bg = "#1a1a1a" })
      vim.api.nvim_set_hl(0, "CursorLineSign", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "CursorLineFold", { link = "CursorLine" })
      vim.api.nvim_set_hl(0, "FoldColumn", { link = "Comment" })
      vim.api.nvim_set_hl(0, "Whitespace", { ctermfg = 104, fg = "#6767d0" })

      vim.api.nvim_set_hl(0, "MoltenOutputBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { link = "MoonflyCrimson" })
      vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { link = "MoonflyBlue" })
      vim.api.nvim_set_hl(0, "MoltenOutputFooter", { link = "Comment" })
      vim.api.nvim_set_hl(0, "MoltenOutputWin", { link = "Normal" })
    end,
  },
  {
    "benlubas/neoscroll.nvim", -- fork that adds the time_scale option to scroll faster
    lazy = false,
    -- dev = true,
    opts = {
      mappings = { "<C-u>", "<C-d>" },
      stop_eof = false,
      time_scale = 0.3,
      pre_hook = function()
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.opt.eventignore:append({
          "WinScrolled",
          "CursorMoved",
        })
      end,
      post_hook = function()
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.opt.eventignore:remove({
          "WinScrolled",
          "CursorMoved",
        })
      end,
    },
  },
  { "folke/which-key.nvim", config = true, lazy = false },
  {
    "luukvbaal/statuscol.nvim",
    cond = not MarkdownMode(),
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        relculright = true,
        segments = {
          {
            sign = { namespace = { "gitsigns" }, name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc } },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = { enabled = false },
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local custom = {
        codeblock_highlight = false,
        dash_string = "━",
      }
      local qmd = vim.tbl_deep_extend("force", custom, { treesitter_language = "markdown" })

      require("headlines").setup({
        markdown = custom,
        quarto = vim.tbl_deep_extend("force", require("headlines").config.markdown, qmd),
        neorg = vim.tbl_deep_extend("force", custom, { fat_headlines = false }),
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        before = "fg",
        keyword = "bg",
        after = "",
      },
    },
  },
}
