local M = {}

---run all qmd cells with magma.
---requires that magma is initialized
M.run_all() = function()
end

---get all the code cells in the current buffer
---@param language string the language of the buffer to get
---@return table a list of row start and end pairs
local function get_all_cells(language)
  local cells = {}
  return {}
end
