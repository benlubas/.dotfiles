require("benlubas.globals")

require("benlubas.treesitter")
require("benlubas.packer")
require("benlubas.set")
require("benlubas.remap")

require("benlubas.lsp")
require("benlubas.autocomplete")
require("benlubas.neotest")
require("benlubas.dap")
require("benlubas.autocommands")

-- clipboard fix for wsl
vim.cmd([[
  if has('wsl')
    let g:clipboard = {
      \   'name': 'wslClipboard',
      \   'copy': {
      \      '+': '/home/linuxbrew/.linuxbrew/bin/win32yank.exe -i --crlf',
      \      '*': '/home/linuxbrew/.linuxbrew/bin/win32yank.exe -i --crlf',
      \    },
      \   'paste': {
      \      '+': '/home/linuxbrew/.linuxbrew/bin/win32yank.exe -o --lf',
      \      '*': '/home/linuxbrew/.linuxbrew/bin/win32yank.exe -o --lf',
      \   },
      \   'cache_enabled': 1,
      \ }
  endif
]])
