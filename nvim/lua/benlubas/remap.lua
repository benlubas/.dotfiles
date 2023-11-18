-- I have sneak installed that that remaps s and S to sneak
-- I use better escape. so in base.lua, jk and kj are remapped to esc

-- just a reminder that <C-w> in insert mode deletes a word at a time.

-- move things up and down and tab format as you go
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

vim.keymap.set("n", "U", "<C-r>", { desc = "redo" })

vim.keymap.set("n", "=a", "gg=G<C-o>zz", { desc = "tab format the whole document" })

vim.keymap.set("n", "^", "<C-^>", { desc = "alternate file" }) -- _ does the same thing as ^

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })

vim.keymap.set("n", "M", ":M<CR>", { desc = "open messages in a float", silent = true })

vim.keymap.set("n", "<leader>cp", [[:let @+ = expand("%:p")<CR>]],
  { desc = "copy full path to clipboard", silent = true })
vim.keymap.set("n", "<leader>ct", [[:let @+ = expand("%:t")<CR>]],
  { desc = "copy relative path to clipboard", silent = true })

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "open signature help" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
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
