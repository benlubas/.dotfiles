-- plugin specific binds are probably defined with that plugin in the plugins folder

-- I have sneak installed that that remaps s and S to sneak

-- just a reminder that
-- <C-w> in insert mode deletes a word at a time.

-- TEMP BINDS
vim.keymap.set("n", "<leader><leader>h", ":set cmdheight=1<CR>")
vim.api.nvim_create_user_command("JestPort", function()
  pcall(vim.cmd, [[%s/\.to\.not/.not.to/g]])
  pcall(vim.cmd, [[%s/to\.have\.text/toHaveTextContent/g]])
  pcall(vim.cmd, [[%s/\.reset()/.mockClear()/g]])
  pcall(vim.cmd, [[%s/\.returns(/.mockReturnValue(/g]])
  pcall(vim.cmd, [[%s/\.resolves(/.mockResolvedValue(/g]])
  pcall(vim.cmd, [[%s/\.rejects(/.mockRejectedValue(/g]])
  pcall(vim.cmd, [[%s/\.to\.have\.been\.called/.toHaveBeenCalled/g]])
  pcall(vim.cmd, [[%s/\.toHaveBeenCalledOnce;/.toHaveBeenCalledTimes(1);/g]])
  pcall(vim.cmd, [[%s/\.to\.have\.been\.called\.with/.toHaveBeenCalledWith/g]])
  pcall(vim.cmd, [[%s/to\.have\.text/toHaveTextContent/g]])
  pcall(vim.cmd, [[%s/to\.eql(/toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.eq(/toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.not\.eq(/not.toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.be\.null/toBeNull()/g]])
  pcall(vim.cmd, [[%s/to\.be\.false/toBe(false)/g]])
  pcall(vim.cmd, [[%s/to\.be\.true/toBe(true)/g]])
  pcall(vim.cmd, [[%s/to\.equal(/toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.deep\.equal(/toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.deep\.eq(/toEqual(/g]])
  pcall(vim.cmd, [[%s/to\.deep\.contain/toContainEqual/g]])
  pcall(vim.cmd, [[%s/to\.deep\.include/toContainEqual/g]])
  pcall(vim.cmd, [[%s/to\.have\.lengthOf(/toHaveLength(/g]])
  pcall(vim.cmd, [[%s/to\.have\.length(/toHaveLength(/g]])
  pcall(vim.cmd, [[%s/to\.have\.className(/toHaveClass(/g]])
  pcall(vim.cmd, [[%s/to\.have\.value(/toHaveValue(/g]])
  pcall(vim.cmd, [[%s/to\.have\.members(\[\(.*\)\]);/toContain(\1);/g]])
  pcall(vim.cmd, [[%s/to\.include(/toContain(/g]])
  pcall(vim.cmd, [[%s/toHaveBeenCalledTwice/toHaveBeenCalledTimes(2)/g]])
  pcall(vim.cmd, [[%s/toHaveBeenCalled;/toHaveBeenCalled();/g]])
  pcall(vim.cmd, [[%s/this\.sinon\.stub/jest.spyOn/g]])
  pcall(vim.cmd, [[%s/context(/describe(/g]])
  pcall(vim.cmd, [[%s/\.args\[/.mock.calls[/g]])
  pcall(vim.cmd, [[%s/function ()/() =>/g]])
  pcall(vim.cmd, [[%s/function (done)/async () =>/g]])
end, {})

-- move things up and down and tab format things
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

vim.keymap.set("n", "<leader><leader>cp", ':let @+ = expand("%:p")<cr>', { desc = "copy full file path to clipboard" })

vim.keymap.set("n", "^", "<C-^>", { desc = "alternate file" }) -- _ does the same thing as ^

vim.keymap.set("n", "=a", "gg=G<C-o>zz", { desc = "tab format the whole document" })

-- quit/file tree
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })
-- vim.keymap.set("n", "<leader>e", "<cmd>!silent w<CR><cmd>Ex<CR>", { desc = "write quit to netrw" })
-- vim.keymap.set("n", "<leader>E", "<cmd>Ex<CR>", { desc = "quit to netwr" })

vim.keymap.set(
  "n",
  "<leader><leader>t",
  "<Plug>PlenaryTestFile",
  { desc = "run plennary test file" }
)

-- folding
vim.keymap.set("n", "<leader>i", "za", { desc = "toggle fold" })
-- "zC" Close all folds under cursor
-- "zO" Open all folds under the cursor

-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>Y", '"+y$')
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
