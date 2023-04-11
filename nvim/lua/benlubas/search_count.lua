-- This file contains the logic for correctly generating a count of the number
-- of matches a `/` or `?` search comes back with
-- The default has a max of 99, which is great for most cases, but not enough
-- for specific scenarios
--
--Usage:
-- Place the result of get_search_count() in your status bar or where ever you
-- want.
-- either leave hlsearch set to true, or use a keybind to toggle it. After toggling
-- make a call to `calc_search_count()` so the count is calculated
local M = {}

M.update_search_count = function()
  M.calc_search_count()
  require('lualine').refresh()
end

M.calc_search_count = function()
  if vim.v.hlsearch == 1 then
    local sinfo = vim.fn.searchcount { maxcount = 0 }
    Search_count = (sinfo.incomplete ~= nil and sinfo.incomplete > 0 and vim.api.nvim_get_mode()[0] == 'n')
        and '[?/?]'
        or ('[%s/%s]'):format(sinfo.current, sinfo.total)
  else
    Search_count = ''
  end
end

-- gets the value in the global variable or '' if not set
M.get_search_count = function()
  return Search_count or ''
end

-- update the search count after a new search and the highlight group is on
-- this function also gets called after turning the highlight group on, so this
-- auto command if for cases when hlsearch is on and then we search for something
local search_count_group = vim.api.nvim_create_augroup('search_count_group', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost', 'CmdlineLeave', 'CmdwinLeave' }, {
  group = search_count_group,
  callback = M.update_search_count
})

-- this is a weird hack to get around the fact that CmdlineLeave isn't triggered when you hit enter
-- to start a search.
vim.keymap.set("c", "<cr>", "<cr>:<esc>")

return M
