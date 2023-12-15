local condense_blanklines = function(text)
  return string.gsub(text, "\n\n+", "\n\n")
end

B = function(cmd)
  local res = vim.api.nvim_exec2(cmd, { output = true })
  local text = condense_blanklines(res.output)
  local lines = vim.split(text, "\n")
  local bufnr = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  vim.api.nvim_buf_set_name(bufnr, "messages")
  vim.api.nvim_buf_set_option(bufnr, "bufhidden", "delete")

  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local winnr = vim.api.nvim_open_win(bufnr, true, {
    title = { { "━━━━━━━━", "FloatBorder" }, { " messages (newlines condensed) ", "Title" } },
    border = { "", "━", "", "", "", "", "", "" },
    relative = "editor",
    width = width,
    height = height / 2 - 1,
    col = 0,
    row = height - height / 2 - 2,
  })
  vim.api.nvim_win_set_option(winnr, "winhighlight", "Normal:MsgArea,NormalNC:MsgArea")

  return winnr
end

vim.api.nvim_create_user_command("M", function(_) B("messages") end, {})
