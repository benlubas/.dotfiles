vim.bo.tw = 85
vim.opt_local.formatoptions:append("t")
vim.opt_local.concealcursor = "nc"
vim.opt_local.conceallevel = 2

-- remove ">" from the comment option so that quotes don't continue `>` on each line
vim.bo.comments = vim.bo.comments:gsub("n:>,?", "")
