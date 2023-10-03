-- copy code and remove leading whitespace
-- TODO: There's a bug either in this or neovim which causes this to break sometimes. It'll appear
-- to copy the text, but pasting reveals that the whitespace wasn't removed, and trying to paste
-- again will just error entirely, with an empty clipboard error
-- seems to work a vast majority of the time, but when it fails, it fails consistently

local M = {}

--- clean the copied code currently in the clipboard

M.clean = function()
  local clipboard = vim.fn.getreg("+") .. ""
  local thing = clipboard:gmatch("([^\n]*\n)")
  local line1 = thing()
  if not line1 then
    line1 = clipboard
  end
  local m = line1:match("^%s*")
  local leading_spaces = #m
  local lines = { line1 }
  for line in thing do
    if line == "\n" then
      table.insert(lines, line)
      goto continue
    end
    m = line:match("^%s*")
    if #m < leading_spaces then
      leading_spaces = #m
    end
    table.insert(lines, line)
    :: continue ::
  end
  for i, line in ipairs(lines) do
    lines[i] = line:sub(leading_spaces + 1)
  end

  local val = P(table.concat(lines, ""))
  vim.schedule(function()
    vim.fn.setreg("+", val)
  end)
end

return M
