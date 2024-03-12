local del_qf_item = function()
  local items = vim.fn.getqflist()
  local line = vim.fn.line('.')
  table.remove(items, line)
  vim.fn.setqflist(items, "r")
  vim.api.nvim_win_set_cursor(0, { line, 0 })
end

-- this is super basic. I might improve it at some point, but it's good enough for how little I use
-- the QF list
vim.keymap.set("n", "dd", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
vim.keymap.set("v", "D", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
