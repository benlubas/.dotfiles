vim.g.mapleader = " "

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = { 80 }

vim.opt.smartindent = true

vim.opt.wrap = false

-- Net-rw stuff 

vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_liststyle = 3 -- tree style

vim.opt.spell = true
vim.opt.spelloptions = 'camel'
