require("benlubas.globals")
require("benlubas.set")
require("benlubas.remap")
require("benlubas.autocommands")
require("benlubas.filetype")

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
