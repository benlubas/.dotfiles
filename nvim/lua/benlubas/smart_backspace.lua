local M = {}

-- from https://www.reddit.com/r/neovim/comments/146gya4/comment/jnrl8lu/?utm_source=share&utm_medium=web2x&context=3
M.smart_backspace = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local char = vim.api.nvim_get_current_line():sub(0, col)
  if char:match("^%s*$") then
    local removed_line_above = false
    -- loop while the previous line is empty, and delete all the empty lines
    local previous_line = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]
    while previous_line:match("^%s*$") do
      removed_line_above = true
      vim.api.nvim_buf_set_lines(0, line - 2, line - 1, false, {})
      line = line - 1
      previous_line = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]
    end

    -- indent the current line if the correct indent is to the left of the current position
    local indent = vim.fn.indent(line) -- current indent level. We need to determine the correct indent level though
    local keys = vim.api.nvim_replace_termcodes("==", true, false, true)
    vim.api.nvim_feedkeys(keys, "x", false)
    local formatted_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    local new_indent = #formatted_line:match("^%s*")
    vim.api.nvim_input("<esc>I")
  else
    -- send a number of backspaces that matches the number of whitespaces - 1?
    vim.api.nvim_input("<bs>")
  end
end

return M
