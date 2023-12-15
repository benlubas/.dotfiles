vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = ""

-- vim.opt.number = false
-- vim.opt.relativenumber = false
vim.opt.numberwidth = 1
vim.opt.foldcolumn = "0"
vim.opt.signcolumn = "auto"

vim.opt.textwidth = 0
vim.opt.colorcolumn = ""

vim.opt.list = false

vim.opt.scrolloff = 0
vim.opt.sidescrolloff = 0

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "github.com_*.txt",
  command = "set filetype=markdown",
})

vim.keymap.set("n", "k", "gk", { silent = true, desc = "up" })
vim.keymap.set("n", "j", "gj", { silent = true, desc = "down" })
vim.keymap.set("n", "_", "g0", { silent = true, desc = "startline" })
vim.keymap.set("n", "$", "g$", { silent = true, desc = "endline" })
