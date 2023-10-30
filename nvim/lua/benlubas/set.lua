vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.vim_json_conceal = false

if not IsLinux() then
  vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
end

vim.opt.mouse = "a"

vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '|'

vim.o.splitright = true
vim.o.splitbelow = true

-- gutter
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.foldcolumn = "1"
vim.opt.signcolumn = "yes:3"

vim.opt.fillchars = {
  eob = " ",
  foldopen = "󰍝",
  foldclose = "󰍟",
  foldsep = " ",
  fold = " ",
}

vim.opt.conceallevel = 2
vim.opt.concealcursor = "c"

vim.opt.ttimeoutlen = 100

-- colors
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.colorcolumn = { 101 } -- 101 so that the 100th char isn't in the line (looks weird)

-- comp menu
vim.opt.pumblend = 13
vim.opt.pumheight = 10

-- indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- listchars
vim.opt.list = true
vim.opt.listchars = "trail:,tab: "

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true -- show the currently matched pattern
vim.opt.shortmess:append("Ss") -- don't show search count, don't show 'search hit bottom'
vim.opt.infercase = true -- case insensitive search until you use a capital letter

-- formatting
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.textwidth = 100 -- break comment lines and others at 100 chars

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- netrw
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_liststyle = 3 -- tree style

-- spelling
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = "" -- this is the pattern to determine what's the end of a sentence
-- so no pattern = no capital letter check after .

-- misc
vim.opt.swapfile = false
vim.opt.undofile = true
