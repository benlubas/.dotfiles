vim.g.mapleader = " "

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
vim.opt.shortmess:append('Ss')

vim.opt.colorcolumn = { 100 }

-- formatting
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.textwidth = 99

-- auto command to remove the stupid comment + enter behavior including this in set becuase I should
-- just be able to set this this shit and not have it get overriden in the ftplugin shit that runs
-- for each file.
local group = vim.api.nvim_create_augroup('fix comment enter', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    -- not really sure why lsp is complaining
    vim.opt.formatoptions:remove({'o', 'r'})
    vim.opt.formatoptions:append({'c'})
  end,
  group = group,
  pattern = '*',
})


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
