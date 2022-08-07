
require('nvim-treesitter.configs').setup{
  require'nvim-treesitter.configs'.setup {
    indent = {
      enable = true
    }
  }
}

--folding (this is experimental and doesn't seem to work like this.. 
--vim.opt.foldmethod=expr 
--vim.opt.foldexpr=nvim_treesitter#foldexpr()
