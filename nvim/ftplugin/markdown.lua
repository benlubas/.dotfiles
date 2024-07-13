-- markdown link text objects for i and a
vim.keymap.set({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').mdlink('inner')<CR>", { buffer = true })
vim.keymap.set({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').mdlink('outer')<CR>", { buffer = true })
