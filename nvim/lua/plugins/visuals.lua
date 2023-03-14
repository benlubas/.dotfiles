-- All of the visual changes that I'm running. This includes, moonfly theme, neoscroll,
-- which-key, devicons, indent_blankline, and lualine

return {
  {
    "bluz71/vim-moonfly-colors",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyTransparent = true
      vim.g.moonflyCursorColor = true
      vim.g.moonflyItalics = false
      vim.g.moonflyUnderlineMatchParen = true
      vim.g.moonflyVirtualTextColor = true

      vim.cmd("syntax enable")
      vim.cmd([[colorscheme moonfly]])

      vim.cmd([[highlight CursorLine ctermbg=238 guibg=#111111]])
    end,
  },
  {
    "benlubas/neoscroll.nvim", -- fork that adds the time_scale option to scroll faster
    lazy = false,
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>" },
      hide_cursor = false,
      stop_eof = false,
      time_scale = 0.3
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        names = false, -- "Name" codes like Blue or blue
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext",
        virtualtext = "■",
      },
    }
  },
  { "folke/which-key.nvim", config = true, lazy = false },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "moonfly",
          icons_enabled = true,
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } }, -- require("benlubas.search_count").get_search_count },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
    },
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
