-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Navigation
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'} }
  }
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use 'chentoast/marks.nvim'

  -- lsp and auto completion 
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use 'evanleck/vim-svelte'

  use 'simrat39/rust-tools.nvim'

  -- GIT 
  use {
    'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Tree sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }


  -- Visual improvements
  use 'karb94/neoscroll.nvim'
  use 'bluz71/vim-moonfly-colors'

  use {
    'nvim-lualine/lualine.nvim',
     requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'lukas-reineke/indent-blankline.nvim'

  use 'folke/which-key.nvim'
end)


