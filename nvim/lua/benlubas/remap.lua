local nnoremap = require('benlubas.keymap').nnoremap
local inoremap = require('benlubas.keymap').inoremap
local vnoremap = require('benlubas.keymap').vnoremap
-- Harpoon binds are in plugin/harpoon.lua

-- esc bind
inoremap('kj', '<esc>')
inoremap('jk', '<esc>')

-- move things up and down (this is insanely nice)
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- just quit
nnoremap('<leader>q', ':q<CR>')
-- write quit to netrw
nnoremap('<leader>e', '<cmd>w<CR><cmd>Ex<CR>')
-- quit to netrw
nnoremap('<leader>E', '<cmd>Ex<CR>')

-- folding. I have folding set to use indent level
nnoremap('<leader>i', 'za') -- toggle one fold
nnoremap('<leader>u', 'zC') -- fold the whole doc
nnoremap('<leader>U', 'zO') -- unfold the whole doc

-- Toggle Neorg table of contents
-- This command sucks in main, but on my branch it works fine. Even when the thing is open.
nnoremap('<leader><leader>t', '<cmd>Neorg toc split<CR>')

-- clipboard binds (copy and paste from sys clipboard) 
-- NOTE, this doesn't work from within WSL 
nnoremap('<leader>y', '"+y')
nnoremap('<leader>p', '"+p')
nnoremap('<leader>P', '"+P')
vnoremap('<leader>y', '"+y')
vnoremap('<leader>p', '"+p')

-- add empty line above/below
nnoremap("<leader>O", ":call BlankUp(v:count1)<CR>", { silent = true })
nnoremap("<leader>o", ":call BlankDown(v:count1)<CR>", { silent = true })

-- be able to repeat those commands:
-- NOTE: This method is hard coded to repeat " o" when `.` is pressed after
-- the command above, so if "<leader>o" is ever changed, you need to change
-- the thing below as well. Annoying, but why would you ever change <leader>o?
vim.cmd [[
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

local tb = require('telescope.builtin')
-- TELESCOPE BINDS --
-- find files in working dir
nnoremap('<leader>f', function() require('benlubas.telescope-project-files').project_files() end)
-- Find in current file
nnoremap('<leader>j', '<cmd>Telescope current_buffer_fuzzy_find<CR>')
-- Find a word in a file in the directory
nnoremap('<leader>k', '<cmd>Telescope live_grep<CR>')
-- search dot files
nnoremap('<leader>l', function()
  local dir = vim.env.HOME .. '/github/.dotfiles'
  tb.find_files({
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden', dir },
  })
end)
-- Symbols with extra sources
nnoremap('<leader>gs', function() tb.symbols({ sources = { 'emoji', 'nerd', 'julia' } }) end)
-- search help tags
nnoremap('<leader>h', '<cmd>Telescope help_tags<CR>')
-- help with word under cursor 
nnoremap('<leader>wh', function() tb.help_tags({ default_text = vim.fn.expand("<cword>") }) end)
-- help with WORD under cursor
nnoremap('<leader>Wh', function() tb.help_tags({ default_text = vim.fn.expand("<cWORD>") }) end)
-- help with visual selection
vnoremap('<leader>h',  function() tb.help_tags({ default_text = vim.fn.expand("<cword>") }) end)
-- clipboard
nnoremap('<leader>c', '<cmd>Telescope neoclip<CR>')
-- todo's 
nnoremap('<leader>t', '<cmd>TodoTelescope<CR>')

-- LSP BINDS
nnoremap("H", "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
nnoremap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
nnoremap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nnoremap("gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
nnoremap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
nnoremap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

-- Neo Git
nnoremap("<leader>gi", "<cmd>Neogit<CR>")

-- Spelling binds because the normal ones kinda suck
nnoremap("<leader>sw", "]s") -- Next misspelled word
nnoremap("<leader>sb", "[s") -- previous misspelled word
nnoremap("<leader>ss", function() -- this is actually sick.
  tb.spell_suggest(require('telescope.themes').get_cursor())
end)
nnoremap("<leader>sa", "zg") -- add word under cursor to dictionary 
nnoremap("<leader>sr", "zr") -- remove word under cursor from dictionary
nnoremap("<leader>st", "<cmd>set spell!<CR>") -- toggle spellcheck

-- toggle highlight search 
-- NOTE: the c-f bind is remapped by 'neoscroll' plugin for smooth scrolling, so that plugin 
-- needs extra setup for this to work with it
nnoremap("<C-f>", function()
  -- So, 0 == true in lua... what the fuck
  local b = {[0] = false, [1] = true}
  vim.opt.hlsearch = not b[vim.v.hlsearch]
  require('benlubas.search_count').calc_search_count()

  require('lualine').refresh()
  -- without the above line we would still get an update after ~1 second (how often the bar 
  -- refreshes normally), but that's slow, so this command triggers the update itself
end)

