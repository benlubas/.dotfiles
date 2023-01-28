-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)

  use("nvim-telescope/telescope-fzf-native.nvim")
  use({
    "AckslD/nvim-neoclip.lua",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("neoclip").setup()
    end,
  })
  use("nvim-telescope/telescope-symbols.nvim")
  -- harpoon
  use("ThePrimeagen/harpoon")

  -- lsp type stuff
  use("neovim/nvim-lspconfig")
  use("evanleck/vim-svelte")
  use("williamboman/nvim-lsp-installer")
  use("simrat39/rust-tools.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- dap
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  use("mxsdev/nvim-dap-vscode-js")

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")
  use("saadparwaiz1/cmp_luasnip")
  use("onsails/lspkind.nvim")
  use("windwp/nvim-autopairs")

  use("ray-x/lsp_signature.nvim")

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
