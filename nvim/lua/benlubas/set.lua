vim.g.mapleader = " "

vim.opt.mouse = "a"

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
vim.opt.foldlevelstart = 99
-- vim.opt.foldmethod = "indent"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.shortmess:append('Ss')


-- formatting
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.textwidth = 99

vim.opt.scrolloff = 8

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
