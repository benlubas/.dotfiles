-- This file contains the logic for correctly generating a count of the number
-- of matches a `/` or `?` search comes back with
-- The default has a max of 99, which is great for most cases, but not enough

-- Usage:
--  Place the result of get_search_count() in your status bar or where ever you
--  want.
--  either leave hlsearch set to true, or use a keybind to toggle it. After toggling
--  make a call to `calc_search_count()` so the count is calculated
local M = {}

M.update_search_count = function()
  M.calc_search_count()
  require("lualine").refresh()
end

M.calc_search_count = function()
  if vim.v.hlsearch == 1 then
    local sinfo = vim.fn.searchcount({ maxcount = 0 })
    Search_count = (
      sinfo.incomplete ~= nil
      and sinfo.incomplete > 0
      and vim.api.nvim_get_mode()[0] == "n"
    )
        and "[?/?]"
      or ("[%s/%s]"):format(sinfo.current, sinfo.total)
  else
    Search_count = ""
  end
end

-- gets the value in the global variable or '' if not set
M.get_search_count = function()
  return Search_count or ""
end

-- update the search count after a new search and the highlight group is on
-- this function also gets called after turning the highlight group on, so this
-- auto command if for cases when hlsearch is on and then we search for something
local search_count_group = vim.api.nvim_create_augroup("search_count_group", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "CmdlineLeave", "CmdwinLeave" }, {
  group = search_count_group,
  callback = M.update_search_count,
})

-- Keybinds --

-- this is a weird hack to get around the fact that CmdlineLeave isn't triggered when you hit enter
-- to start a search.
vim.keymap.set("c", "<cr>", "<cr>:<esc>")

-- NOTE: the c-f bind is remapped by 'neoscroll' plugin for smooth scrolling, so that plugin
-- needs extra setup for this to work with it
local toggle_highlight = function()
	local b = { [0] = false, [1] = true }
	vim.opt.hlsearch = not b[vim.v.hlsearch]
	require("benlubas.search_count").calc_search_count()

	require("lualine").refresh()
end

-- remaps to also update the search count numerator
vim.keymap.set("n", "n", function()
  vim.api.nvim_feedkeys("n", "n", true)
  vim.schedule(M.update_search_count)
end, { desc = "move to the next search result" })

vim.keymap.set("n", "N", function()
  vim.api.nvim_feedkeys("N", "n", true)
  vim.schedule(M.update_search_count)
end, { desc = "move to the previous search result" })

-- turn on highlight and search count on * and #
vim.keymap.set("n", "*", function()
  vim.api.nvim_feedkeys("*", "n", true)
  vim.schedule(M.update_search_count)
  vim.opt.hlsearch = true;
end, { desc = "search for the word under the cursor" })

-- this remap makes it easier to navigate with n/N as normal after a # search
vim.keymap.set("n", "#", function()
  vim.api.nvim_feedkeys("*NN", "n", true)
  vim.schedule(M.update_search_count)
  vim.opt.hlsearch = true;
end, { desc = "search backwards for the word under the cursor" })

vim.keymap.set("n", "<leader><leader>f", toggle_highlight, { desc = "toggle search highlight" })

return M
