local nnoremap = require('benlubas.keymap').nnoremap
local inoremap = require('benlubas.keymap').inoremap
local vnoremap = require('benlubas.keymap').vnoremap

-- esc bind 
inoremap('kj', '<esc>')

-- just quit
nnoremap('<leader>q', ':q<CR>')
-- write quit to netrw
nnoremap('<leader>e', '<cmd>w<CR><cmd>Ex<CR>')
-- quit to netrw
nnoremap('<leader>E', '<cmd>Ex<CR>')

-- add empty line above/below 
nnoremap("<leader>O", ":call BlankUp(v:count1)<CR>", {silent = true})
nnoremap("<leader>o", ":call BlankDown(v:count1)<CR>", {silent = true})

-- be able to repeat those commands:
-- NOTE: This method is hard coded to repeat " o" when `.` is pressed after 
-- the command above, so if "<leader>o" is ever changed, you need to change 
-- the thing below as well. Annoying, but why would you ever change <leader>o?
vim.cmd[[
  function! BlankUp(count) abort
    put!=repeat(nr2char(10), a:count)
    ']+1
    silent! call repeat#set(" O", a:count)
  endfunction

  function! BlankDown(count) abort
    put =repeat(nr2char(10), a:count)
    '[-1
    silent! call repeat#set(" o", a:count)
  endfunction
]]

-- TELESCOPE BINDS
nnoremap('<leader>f', '<cmd>Telescope find_files<CR>')
nnoremap('<leader>j', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
nnoremap('<leader>k', '<cmd>Telescope live_grep<CR>')
nnoremap('<leader>c', '<cmd>Telescope neoclip<CR>')
nnoremap('<leader>h', '<cmd>Telescope help_tags<CR>')
nnoremap('<leader>wh', function()
  require('telescope.builtin')
    .help_tags({ default_text = vim.fn.expand("<cword>") })
end)
nnoremap('<leader>Wh', function()
  require('telescope.builtin')
    .help_tags({ default_text = vim.fn.expand("<cWORD>") })
end)
vnoremap('<leader>h', function()
  require('telescope.builtin')
    .help_tags({ default_text = vim.fn.expand("<cword>") })
end)

-- LSP BINDS 
nnoremap("H",     "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("gd",    "<cmd>lua vim.lsp.buf.definition()<CR>")
nnoremap("gD",    "<cmd>lua vim.lsp.buf.implementation()<CR>")
nnoremap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nnoremap("gt",    "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nnoremap("gr",    "<cmd>lua vim.lsp.buf.references()<CR>")
nnoremap("g0",    "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
nnoremap("gW",    "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', '<leader>fmt', vim.lsp.buf.formatting, other)


-- Neo Git
nnoremap("<leader>gi", "<cmd>Neogit<CR>")

-- Spelling binds because the normal ones kinda suck 
nnoremap("<leader>sw", "]s") -- Next misspelled word
nnoremap("<leader>sb", "[s") -- previous misspelled word
nnoremap("<leader>ss", "z=") -- bring up suggestions
nnoremap("<leader>sa", "zg") -- add word under cursor to dictionary 
nnoremap("<leader>sr", "zr") -- remove word under cursor from dictionary
nnoremap("<leader>se", "<cmd>set spell!<CR>") -- toggle spellcheck

