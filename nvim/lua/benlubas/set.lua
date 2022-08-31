vim.g.mapleader = " "

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor"

-- numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6

-- colors
vim.opt.termguicolors = true
-- cursor line
vim.opt.cursorline = true

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- folds 
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.shortmess = vim.opt.shortmess + 'S'

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
