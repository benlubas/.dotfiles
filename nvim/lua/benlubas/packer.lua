-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- 'Vanilla' Plugins
  use 'tpope/vim-surround' -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  use 'tpope/vim-repeat' -- allows some plugin actions to be repeated with .
  use 'numToStr/Comment.nvim' -- comment things with vim motions

  -- Unit Testing
  use {
    'nvim-neotest/neotest',
    requires = {
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
    }
  }

  -- Autosave
  use {
    'Pocco81/auto-save.nvim',
    -- 'XXiaoA/auto-save.nvim', -- this is a branch that fixes a bug, it should be in main soon anyway
    config = function()
      require('auto-save').setup()
    end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'BurntSushi/ripgrep' } }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use {
    'AckslD/nvim-neoclip.lua',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('neoclip').setup()
    end
  }
  use 'nvim-telescope/telescope-symbols.nvim'
  -- harpoon
  use 'ThePrimeagen/harpoon'

  --marks
  use 'chentoast/marks.nvim'

  -- lsp type stuff
  use 'neovim/nvim-lspconfig'
  use 'evanleck/vim-svelte'
  use 'williamboman/nvim-lsp-installer'
  use 'simrat39/rust-tools.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'MunifTanjim/prettier.nvim'

  -- autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  use 'windwp/nvim-autopairs' -- auto pairs (kinda it's own plugin)


  -- snippets
  use 'L3MON4D3/LuaSnip'

  -- GIT
  use {
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'lewis6991/gitsigns.nvim',
  }

  -- Tree sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Neorg (setup must come after treesitter's)
  use {
    "nvim-neorg/neorg",
    requires = "nvim-lua/plenary.nvim"
  }

  -- Visual improvements
  use 'karb94/neoscroll.nvim'
  use 'bluz71/vim-moonfly-colors'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'folke/todo-comments.nvim'

  -- MISC
  use 'folke/which-key.nvim'
end)
