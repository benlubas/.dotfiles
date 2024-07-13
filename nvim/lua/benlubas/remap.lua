vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

-- I have sneak installed that that remaps s and S to sneak

-- just a reminder that <C-w> in insert mode deletes a word at a time.

-- "smart tab". Tab as far as necessary on a blank line
vim.keymap.set("i", "<Tab>", function()
  local line = vim.api.nvim_get_current_line()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  if line:match("^%s*$") then
    vim.v.lnum = row
    local indent = vim.fn.eval(vim.bo.indentexpr)
    local tabs = vim.fn.shiftwidth()
    local tabbed = line:gsub("\t", (" "):rep(tabs))
    if indent * tabs > #tabbed then
      local new_line = (" "):rep(indent)
      vim.api.nvim_buf_set_lines(0, row - 1, row, true, { new_line })
      vim.api.nvim_win_set_cursor(0, { row, #new_line })
      return
    end
  end
  local key = vim.api.nvim_replace_termcodes("<tab>", true, false, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end)

pcall(vim.keymap.del, "n", "<C-w>d")
pcall(vim.keymap.del, "n", "<C-w><c-d>")

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
vim.keymap.set("n", "<leader>ds", [['m`:'. (&ft == "markdown" ? '' : '%') .'s/\s\+$//e<CR>``']], { desc = "remove trailing spaces", expr = true, silent = true })

-- Conveniently open all the TS dev stuff
vim.api.nvim_create_user_command("TSPlayground", function()
  vim.cmd.InspectTree()
  vim.cmd.EditQuery()
end, {})
