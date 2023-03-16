vim.g.mapleader = " "

vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.swapfile = false
vim.opt.colorcolumn = { 100 }

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.shortmess:append('Ss')

-- formatting
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.textwidth = 99

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Net-rw stuff 
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_liststyle = 3 -- tree style

-- spelling
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = '' -- this is the pattern to determine what's the end of a sentence
-- so no pattern = no capital letter check after .

-- boarders for the text that pops up for autocomplete and stuff
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "single",
})

vim.diagnostic.config({ float = { border = "single" } })
