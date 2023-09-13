-- I have sneak installed that that remaps s and S to sneak
-- I use better escape. so in base.lua, jk and kj are remapped to esc

-- just a reminder that <C-w> in insert mode deletes a word at a time.

-- move things up and down and tab format things
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- Allow j and k to always move a line up or down even if it's a wrapped line
vim.keymap.set("n", "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true, desc = "k or gk" })

vim.keymap.set("n", "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true, desc = "j or gj" })

vim.keymap.set("n", "U", "<C-r>", { desc = "redo" })

vim.keymap.set("n", "=a", "gg=G<C-o>zz", { desc = "tab format the whole document" })

vim.keymap.set("n", "^", "<C-^>", { desc = "alternate file" }) -- _ does the same thing as ^

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })

vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", { desc = "run plennary test file" })

vim.keymap.set("n", "<leader>cf", [[:let @+ = expand("%:p")<CR>]],
  { desc = "copy full path to clipboard", silent = true })
vim.keymap.set("n", "<leader>cr", [[:let @+ = expand("%")<CR>]],
  { desc = "copy relative path to clipboard", silent = true })

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "open signature help" })
vim.keymap.set("i", "<C-h>", function() require("benlubas.smart_backspace").smart_backspace() end, { remap = true })

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

-- smart backspace
-- vim.keymap.set("i", "<BS>", function()
--   require("benlubas.smart_backspace").smart_backspace()
-- end,
--   { desc = "backspace, but remove as much whitespace as possible", expr = true, noremap = true, replace_keycodes = false })
