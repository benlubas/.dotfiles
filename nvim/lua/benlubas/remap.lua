-- Harpoon binds are in ./../../plugin/harpoon.lua

-- I have sneak installed that that remaps s and S to sneak

-- just a reminder that
-- <C-w> in insert mode deletes a word at a time.

-- why not both?
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("i", "jk", "<esc>")

-- move things up and down (this is insanely nice)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- tab format the whole document
vim.keymap.set("n", "=a", "gg=G<C-o>zz")

-- delete trailing white spaces
vim.keymap.set("n", "<leader>ds", function()
  require("mini.trailspace").trim()
end)

-- quit/file tree
vim.keymap.set("n", "<leader>q", ":q<CR>") -- just quit
vim.keymap.set("n", "<leader>e", "<cmd>!silent w<CR><cmd>Ex<CR>") -- write quit to netrw
vim.keymap.set("n", "<leader>E", "<cmd>Ex<CR>") -- quit to netrw

-- run the test file.
vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile")

-- folding
vim.keymap.set("n", "<leader>i", "za") -- toggle one fold
vim.keymap.set("n", "<leader><leader>f", "zC") -- fold the whole doc
vim.keymap.set("n", "<leader><leader>F", "zO") -- unfold the whole doc

-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')

-- add empty line above/below
vim.keymap.set("n", "<leader>O", ":call BlankUp(v:count1)<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", ":call BlankDown(v:count1)<CR>", { silent = true })

-- be able to repeat those commands:
-- NOTE: This method is hard coded to repeat " o" when `.` is pressed after
-- the command above, so if "<leader>o" is ever changed, you need to change
-- the thing below as well. Annoying, but why would you ever change <leader>o?
vim.cmd([[
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
]])

-- Spelling binds because the normal ones kinda suck
vim.keymap.set("n", "<leader>sw", "]s") -- Next misspelled word
vim.keymap.set("n", "<leader>sb", "[s") -- previous misspelled word
vim.keymap.set("n", "<leader>ss", function() -- this is actually sick.
  tb.spell_suggest(require("telescope.themes").get_cursor())
end)
vim.keymap.set("n", "<leader>sa", "zg") -- add word under cursor to dictionary
vim.keymap.set("n", "<leader>sr", "zr") -- remove word under cursor from dictionary
vim.keymap.set("n", "<leader>st", "<cmd>set spell!<CR>") -- toggle spellcheck

-- toggle highlight search
-- Note: the c-f bind is remapped by 'neoscroll' plugin for smooth scrolling, so that plugin
-- needs extra setup for this to work with it
local toggle_highlight = function()
  -- So, 0 == true in lua... what the fuck
  local b = { [0] = false, [1] = true }
  vim.opt.hlsearch = not b[vim.v.hlsearch]
  require("benlubas.search_count").calc_search_count()

  require("lualine").refresh()
  -- without the above line we would still get an update after ~1 second (how often the bar
  -- refreshes normally), but that's slow, so this command triggers the update itself
end
vim.keymap.set("n", "<C-f>", toggle_highlight)
vim.keymap.set("i", "<C-f>", toggle_highlight)
