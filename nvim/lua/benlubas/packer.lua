-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use("lewis6991/impatient.nvim") -- for caching and better load times

  -- 'Vanilla' Plugins
  use("tpope/vim-surround") -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  use("tpope/vim-repeat") -- allows some plugin actions to be repeated with .
  use("numToStr/Comment.nvim") -- comment things with vim motions
  use("ggandor/leap.nvim") -- s becomes two char, multi line f

  -- Unit Testing
  use({
    "nvim-neotest/neotest",
    requires = {
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
  })
  -- sniprun, run snippets of code in the editor
  use({ "michaelb/sniprun", run = "bash ./install.sh" })

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  })

  -- color picker
  use({
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" }, { "BurntSushi/ripgrep" } },
  })
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
