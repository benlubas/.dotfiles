local M = {}

---get the range of the first code cell in the current buffer between two lines
---@param language string the language of the buffer to get
---@param starting_row number the row to start searching from
---@param ending_row number (optional) the row to end searching at
---@return table | nil table of the start and end row of the cell. Nil if no cells are found
local function get_next_cell(language, starting_row, ending_row)
  ending_row = ending_row or -1
  local buf = vim.api.nvim_win_get_buf(0)
  local lines = vim.api.nvim_buf_get_lines(buf, starting_row, -1, false)
  -- TODO: rewrite this with treesitter?
  for i, line in ipairs(lines) do
    if line:match("^```{" .. language .. "}") then
      local start = i + 1
      local end_ = i + 1 -- end is a keyword
      for j = i + 1, #lines do
        if lines[j]:match("^```") then
          end_ = j - 1
          break
        end
      end
      if start >= end_ then
        return nil
      else
        return { start + starting_row, end_ + starting_row }
      end
    end
    if i + starting_row >= ending_row then
      return nil
    end
  end
  return nil
end

---run all qmd cells above the cursor with magma.
---requires that magma is initialized
M.run_all_above = function(language)
  local i = 0
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = 0
  while true do
    i = i + 1
    local cell = get_next_cell(language, line, cursor_pos[1])
    if cell == nil then
      break
    end
    vim.fn.MagmaEvaluateRange(cell[1], cell[2])
    line = cell[2]
    if i > 10 then
      break
    end
  end
end

return M
