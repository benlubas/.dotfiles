local nnoremap = require("benlubas.keymap").nnoremap
local inoremap = require("benlubas.keymap").inoremap
local vnoremap = require("benlubas.keymap").vnoremap
-- Harpoon binds are in ./../../plugin/harpoon.lua

-- Note that I have sneak installed that that remaps s and S to sneak

-- esc bind
inoremap("kj", "<esc>")
inoremap("jk", "<esc>")

-- move things up and down (this is insanely nice)
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- tab format the whole document
nnoremap("=a", "gg=G<C-o>zz")

-- delete tailing white spaces
nnoremap("<leader>ds", function()
  require("mini.trailspace").trim()
end)

-- quit/file tree
nnoremap("<leader>q", ":q<CR>") -- just quit
nnoremap("<leader>e", "<cmd>!silent w<CR><cmd>Ex<CR>") -- write quit to netrw
nnoremap("<leader>E", "<cmd>Ex<CR>") -- quit to netrw

-- run the test file.
nnoremap("<leader><leader>t", "<Plug>PlenaryTestFile")

-- pick color under cursor
nnoremap("<leader>C", ":Colortils picker<CR>")

-- folding
nnoremap("<leader>i", "za") -- toggle one fold
nnoremap("<leader><leader>f", "zC") -- fold the whole doc
nnoremap("<leader><leader>F", "zO") -- unfold the whole doc

-- clipboard binds (copy and paste from sys clipboard)
-- NOTE, this doesn't work from within WSL
nnoremap("<leader>y", '"+y')
nnoremap("<leader>p", '"+p')
nnoremap("<leader>P", '"+P')
vnoremap("<leader>y", '"+y')
vnoremap("<leader>p", '"+p')

-- add empty line above/below
nnoremap("<leader>O", ":call BlankUp(v:count1)<CR>", { silent = true })
nnoremap("<leader>o", ":call BlankDown(v:count1)<CR>", { silent = true })

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

local tb = require("telescope.builtin")
-- TELESCOPE BINDS --
-- find files in working dir
nnoremap("<leader>fd", function()
  require("benlubas.telescope-project-files").project_files()
end)

-- TODO: This is broken right now.
nnoremap("<leader>fj", function()
  tb.current_buffer_fuzzy_find()
end)

nnoremap("<leader>fa", "<cmd>Telescope live_grep<CR>") -- Find a word in a file in the directory
nnoremap("<leader>fl", function() -- search dot files
  local dir = vim.env.HOME .. "/github/.dotfiles"
  tb.find_files({
    find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
  })
end)
nnoremap("<leader>fh", function()
  tb.find_files({ hidden = true })
end) -- include hidden files in directory search
nnoremap("<leader>fs", function()
  tb.symbols({ sources = { "emoji", "nerd", "julia" } })
end) -- Symbols with extra sources
nnoremap("<leader>h", "<cmd>Telescope help_tags<CR>") -- search help tags
nnoremap("<leader>wh", function()
  tb.help_tags({ default_text = vim.fn.expand("<cword>") })
end) -- help with word under cursor
nnoremap("<leader>Wh", function()
  tb.help_tags({ default_text = vim.fn.expand("<cWORD>") })
end) -- help with WORD under cursor
vnoremap("<leader>h", function()
  tb.help_tags({ default_text = vim.fn.expand("<cword>") })
end) -- help with visual selection
nnoremap("<leader>c", "<cmd>Telescope neoclip<CR>") -- clipboard
nnoremap("<leader>ft", "<cmd>TodoTelescope<CR>") -- todo's

-- LSP BINDS
nnoremap("H", "<cmd>lua vim.lsp.buf.hover()<CR>") -- Open hover information
nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>") -- go to definition of symbol
nnoremap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>") -- go to where the symbol is instantiated
-- nnoremap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>") -- not sure
nnoremap("gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>") -- type def, nice
nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- nnoremap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>") -- not sure what either of these do
-- nnoremap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

-- Neotest
local nt = require("neotest")
nnoremap("<leader>tr", function() nt.run.run() end) -- Run the nearest test
nnoremap("<leader>tR", function() nt.run.run(vim.fn.expand("%")) end) -- Run the current file
nnoremap("<leader>ts", function() nt.run.stop() end) -- stop the nearest test
nnoremap("<leader>ta", function() nt.run.attach() end) -- attach to the nearest test
nnoremap("<leader>th", function() nt.output.open({ enter = true }) end) -- open output window
nnoremap("<leader>td", function() nt.run.run({ strategy = "dap" }) end) -- run the test in debug mode.

-- sniprun
local snip = require("sniprun")
nnoremap("<leader>rr", snip.run) -- Run the block
vnoremap("<leader>rr", function()
  print("running...")
  snip.run("v")
end) -- Run the block
nnoremap("<leader>rs", ":SnipReset<CR>") -- stop any running instances
nnoremap("<leader>rc", ":SnipClear<CR>") -- stop any running instances

-- Neo Git
nnoremap("<leader>gi", "<cmd>Neogit<CR>")

-- Spelling binds because the normal ones kinda suck
nnoremap("<leader>sw", "]s") -- Next misspelled word
nnoremap("<leader>sb", "[s") -- previous misspelled word
nnoremap("<leader>ss", function() -- this is actually sick.
  tb.spell_suggest(require("telescope.themes").get_cursor())
end)
nnoremap("<leader>sa", "zg") -- add word under cursor to dictionary
nnoremap("<leader>sr", "zr") -- remove word under cursor from dictionary
nnoremap("<leader>st", "<cmd>set spell!<CR>") -- toggle spellcheck

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
nnoremap("<C-f>", toggle_highlight)
inoremap("<C-f>", toggle_highlight)
