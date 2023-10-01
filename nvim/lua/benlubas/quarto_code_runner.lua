---@diagnostic disable: need-check-nil
local M = {}

local function match_code_cell(str)
  return str:match("^```{(%a+)}")
end

---get the range of the first code cell in the current buffer between two lines
---@param lang string the language of the code cell to search for
---@param starting_row number the row to start searching from (0 indexed)
---@param ending_row? number (optional) the row to end searching at
---@return table | nil table of the start and end row of the cell. Nil if no cells are found
local function get_next_cell(lang, starting_row, ending_row)
  ending_row = ending_row or -1
  local buf = vim.api.nvim_win_get_buf(0)
  local lines = vim.api.nvim_buf_get_lines(buf, starting_row, -1, false)
  for i, line in ipairs(lines) do
    local language = match_code_cell(line)
    if language == lang then
      local start = i + 1
      local end_ = i + 1 -- end is a keyword
      for j = i + 1, #lines do
        if lines[j]:match("^```") then
          end_ = j - 1
          break
        end
      end
      if start > end_ then
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

-- find the starting line number of the code cell that the cursor is in
local function find_code_cell()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1]
  while line > 0 do
    local str = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    local lang = match_code_cell(str)
    if lang ~= nil then
      return { line = line, lang = lang }
    end
    line = line - 1
  end

  return nil
end

---@param lang string the language of the code cell
---@param start integer the starting row
---@param end_ integer the ending row
local run_with_conjure = function(lang, start, end_)
  local eval = require("conjure.eval")
  local client = require("conjure.client")
  local log = require("conjure.log")

  local lines = vim.api.nvim_buf_get_lines(0, start - 1, end_, false)
  local code = table.concat(lines, "")

  client["with-filetype"](lang, eval["eval-str"], {
    origin = "arbitrary_code_runner",
    code = code,
    ["passive?"] = true, -- don't trigger virtual text or append to the log (b/c it's buggy)
    ["on-result"] = function(r)
      client["with-filetype"](lang, log.append, { ("// %s"):format(r) }, { ["break?"] = true })
    end,
  })
end

---@param start integer the starting row
---@param end_ integer the ending row
local run_with_magma = function(_, start, end_)
  vim.fn.MagmaEvaluateRange(start, end_)
end

local lang_to_method = {
  python = run_with_magma,
  rust = run_with_conjure,
}

local function alert_cell_error(cell)
  if cell == nil then
    vim.notify("No code cell found", vim.log.levels.INFO)
    return true
  end
  return false
end

---run the current code cell that you're in
M.run_cell = function()
  local cell_header = find_code_cell()
  if alert_cell_error(cell_header) then
    return
  end

  local cell = get_next_cell(cell_header.lang, cell_header.line - 1)
  if alert_cell_error(cell) then
    return
  end
  lang_to_method[cell_header.lang](cell_header.lang, cell[1], cell[2])
end

---runs the line of code you're on, makes sure that you're in a code cell
M.run_line = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1]

  local cell_header = find_code_cell()
  if alert_cell_error(cell_header) then
    return
  end
  local cell = get_next_cell(cell_header.lang, cell_header.line - 1)

  if alert_cell_error(cell) then
    return
  end

  if row <= cell[2] and row >= cell[1] then
    lang_to_method[cell_header.lang](cell_header.lang, row, row)
  else
    vim.notify("Not in a code cell", vim.log.levels.INFO)
  end
end

---run all qmd cells above the cursor with magma.
---requires that magma is initialized
M.run_all_above = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = 0
  local cell_header = find_code_cell()

  if alert_cell_error(cell_header) then
    return
  end
  local lang = cell_header.lang

  while true do
    local cell = get_next_cell(lang, line, cursor_pos[1])
    if cell == nil then
      break
    end
    -- run the code
    lang_to_method[lang](lang, cell[1], cell[2])
    line = cell[2]
  end
end

M.attach_run_mappings = function()
  vim.keymap.set("n", "<localleader>rc", M.run_cell, { desc = "run code cell" })
  vim.keymap.set("n", "<localleader>ra", M.run_all_above, { desc = "run all code cells above the cursor" })
  vim.keymap.set("n", "<localleader>rl", M.run_line, { desc = "run line " })
end

M.attach_conjure_mappings = function()
  vim.keymap.set("n", "<localleader>lv", require('conjure.log').vsplit, { desc = "vsplit open conjure log"})
end

return M
