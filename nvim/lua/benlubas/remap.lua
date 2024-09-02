vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

-- I have sneak installed that that remaps s and S to sneak

-- just a reminder that <C-w> in insert mode deletes a word at a time.

-- "smart tab". Tab as far as necessary on a blank line
vim.keymap.set("i", "<Tab>", function()
  local line = vim.api.nvim_get_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local tabs = vim.fn.shiftwidth()
  if line:match("^%s*$") then
    vim.v.lnum = row
    local ok, indent = pcall(vim.fn.eval, vim.bo.indentexpr)
    if not ok then
      goto default
    end
    local tabbed = line:gsub("\t", (" "):rep(tabs))
    if indent > #tabbed then
      local new_line = (" "):rep(indent)
      vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
      vim.api.nvim_win_set_cursor(0, { row, #new_line })
      return
    end
  end
  ::default::
  local key = vim.api.nvim_replace_termcodes(("<space>"):rep(tabs), true, false, true)
  vim.api.nvim_feedkeys(key, "n", false)
end)

vim.keymap.set("i", "<m-i>", function()
  local c = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local indent = line:match("^(%s*)")
  indent = #indent
  vim.v.lnum = c[1]
  local ok, correct_indent = pcall(vim.fn.eval, vim.bo.indentexpr)
  if not ok then
    return
  end

  line = line:gsub("^%s*", (" "):rep(correct_indent))
  vim.api.nvim_buf_set_lines(0, c[1] - 1, c[1], false, { line })
  vim.api.nvim_win_set_cursor(0, { c[1], c[2] + correct_indent - indent })
end)

-- and similarly "smart backspace"
-- NOTE: you need to configure nvim-autopairs with `map_bs = false` otherwise it will override the
-- keybind on buf enter
vim.keymap.set("i", "<bs>", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("%s%s+$") then
    line = line:gsub("%s+$", "")
    return vim.api.nvim_set_current_line(line)
  end
  local ok, autopairs = pcall(require, "nvim-autopairs")
  local keys
  if ok then
    keys = autopairs.autopairs_bs()
  else
    keys = vim.api.nvim_replace_termcodes("<bs>", true, false, true)
  end
  vim.api.nvim_feedkeys(keys, "n", false)
end)

vim.keymap.set("n", "<leader>i", "za", { desc = "toggle fold" })
vim.keymap.set("v", "<leader>i", "zf")

-- move things up and down and tab format as you go
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

-- terminal keybinds
vim.keymap.set("i", "<C-a>", "<C-o>_", { desc = "home" })
vim.keymap.set("i", "<C-e>", "<C-o>$", { desc = "end" })
-- these two are not default, you have to use esc + f/b which is weird as hell
vim.keymap.set("i", "<C-f>", "<C-o>w", { desc = "forward" })
vim.keymap.set("i", "<C-b>", "<C-o>b", { desc = "backward" })

vim.keymap.set("n", "U", "<C-r>", { desc = "redo" })

vim.keymap.set("n", "=a", "gg=G<C-o>zz", { desc = "tab format the whole document" })

vim.keymap.set("n", "^", "<C-^>", { desc = "alternate file" }) -- _ does the same thing as ^

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "quit" })

vim.keymap.set("n", "M", ":mes<CR>", { silent = true })

vim.keymap.set("n", "<leader>yp", function()
  vim.cmd.let("@+=", 'expand("%:p")')
  vim.notify("copied full path to clipboard", vim.log.levels.INFO)
end, { desc = "copy full path to clipboard", silent = true })

vim.keymap.set("n", "<leader>yr", function()
  vim.cmd.let("@+=", 'expand("%:t")')
  vim.notify("copied filename to clipboard", vim.log.levels.INFO)
end, { desc = "copy filename to clipboard", silent = true })

vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "open signature help" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" })

-- clipboard binds (copy and paste from sys clipboard)
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+y$')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

-- add empty line above/below
vim.keymap.set("n", "<leader>O", "m`O<esc>``", { silent = true, desc = "add empty line above" })
vim.keymap.set("n", "<leader>o", "m`o<esc>``", { silent = true, desc = "add empty line below" })

-- spelling related
vim.keymap.set("n", "<leader>Sa", "zg", { desc = "add word to dictionary" })
vim.keymap.set("n", "<leader>St", "<cmd>set spell!<CR>")

-- remove trailing spaces. Only affect the current line in markdown files
vim.keymap.set("n", "<leader>ds", [['m`:'. (&ft == "markdown" ? '' : '%') .'s/\s\+$//e<CR>``']],
  { desc = "remove trailing spaces", expr = true, silent = true })

-- Conveniently open all the TS dev stuff
vim.api.nvim_create_user_command("TSPlayground", function()
  vim.cmd.InspectTree()
  vim.cmd.EditQuery()
end, {})

vim.api.nvim_create_user_command("Scratch", function()
  vim.cmd.enew()
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
end, {})
