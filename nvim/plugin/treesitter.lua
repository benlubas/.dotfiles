require 'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  },
  highlight = {
    enable = true
  },
  ensure_installed = {
    'c',
    'css',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'norg',
    'python',
    'rust',
    'sql',
    'svelte',
    'typescript',
    'yaml',
  }
}

--folding (this is experimental and doesn't seem to work like this..
--vim.opt.foldmethod=expr
--vim.opt.foldexpr=nvim_treesitter#foldexpr()
