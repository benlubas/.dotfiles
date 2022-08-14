vim.g.mapleader = " "

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor"

-- numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 5

-- tabs (I'm going to use 4 begrudgingly)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = { 100 }

vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.scrolloff = 8

-- Net-rw stuff 

vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_liststyle = 3 -- tree style

-- spelling
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
