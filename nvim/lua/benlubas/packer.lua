-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)

-- snippets
  use("L3MON4D3/LuaSnip")

  -- git
  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
  })
  use({
    "lewis6991/gitsigns.nvim",
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("nvim-treesitter/nvim-treesitter-context")
  use("nvim-treesitter/nvim-treesitter-textobjects")

  -- visual improvements
  use("karb94/neoscroll.nvim")
  use("bluz71/vim-moonfly-colors")
  use("kyazdani42/nvim-web-devicons")
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use("lukas-reineke/indent-blankline.nvim")
  use("folke/todo-comments.nvim")

  -- MISC
  use("folke/which-key.nvim")

  -- mini
  use("echasnovski/mini.trailspace")
end)
