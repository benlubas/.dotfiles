
-- I have sneak installed that that remaps s and S to sneak
-- I use better escape. so in base.lua, jk and kj are remapped to esc

-- just a reminder that <C-w> in insert mode deletes a word at a time.

-- move things up and down and tab format things
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

vim.keymap.set("n", "=a", "gg=G<C-o>zz", { desc = "tab format the whole document" })

vim.keymap.set("n", "^", "<C-^>", { desc = "alternate file" }) -- _ does the same thing as ^

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })

vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", { desc = "run plennary test file" })

-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

-- add empty line above/below
vim.keymap.set("n", "<leader>O", ":call BlankUp(1)<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":call BlankDown(1)<CR>", { silent = true })

-- be able to repeat those commands:
vim.cmd([[
  function! BlankUp(count) abort
    put!=repeat(nr2char(10), 1)
    ']+1
    silent! call repeat#set(" O", a:count)
  endfunction

  function! BlankDown(count) abort
    put =repeat(nr2char(10), 1)
    '[-1
    silent! call repeat#set(" o", a:count)
  endfunction
]])

-- zg -- add work under cursor to dictionary
vim.keymap.set("n", "<leader>sa", "zg", { desc = "add word to dictionary" })
vim.keymap.set("n", "<leader>st", "<cmd>set spell!<CR>")

-- toggle highlight search
-- Note: the c-f bind is remapped by 'neoscroll' plugin for smooth scrolling, so that plugin
-- needs extra setup for this to work with it
local toggle_highlight = function()
	-- So, 0 == true in lua... what the fuck
	local b = { [0] = false, [1] = true }
	vim.opt.hlsearch = not b[vim.v.hlsearch]
	require("benlubas.search_count").calc_search_count()

	require("lualine").refresh()
end
vim.keymap.set("n", "<C-f>", toggle_highlight, { desc = "toggle search highlight" })
vim.keymap.set("i", "<C-f>", toggle_highlight, { desc = "toggle search highlight" })
