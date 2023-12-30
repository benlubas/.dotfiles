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
  vim.api.nvim_set_option_value("bufhidden", "delete", { buf = bufnr })

  vim.cmd("12split")
  vim.api.nvim_set_current_buf(bufnr)
end

vim.api.nvim_create_user_command("M", function(_)
  B("messages")
end, {})
