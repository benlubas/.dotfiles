M = {}

local utils = require("telescope.actions.utils")
local actions = require("telescope.actions")

M.mark_file = function(tb)
  actions.drop_all(tb)
  actions.add_selection(tb)
  utils.map_selections(tb, function(selection)
    local file = selection[1]
    pcall(require('harpoon.mark').add_file, file)
  end)
  actions.remove_selection(tb)
end

return M
