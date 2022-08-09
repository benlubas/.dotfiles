-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- 'Vanilla' Plugins
  use 'tpope/vim-surround' -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  use 'tpope/vim-repeat' -- allows some plugin actions to be repeated with .

  -- Autosave 
  use{
    'Pocco81/auto-save.nvim',
    config = function()
       require('auto-save').setup {}
    end,
  }

  -- Navigation
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use {
    'AckslD/nvim-neoclip.lua',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('neoclip').setup()
    end
  }
  use 'chentoast/marks.nvim'

  -- lsp and auto completion 
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'

  use 'evanleck/vim-svelte'

  use 'simrat39/rust-tools.nvim'

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


  -- Visual improvements
  use 'karb94/neoscroll.nvim'
  use 'bluz71/vim-moonfly-colors'
  use 'kyazdani42/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
     requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'lukas-reineke/indent-blankline.nvim'

  -- MISC
  use 'folke/which-key.nvim'
end)


