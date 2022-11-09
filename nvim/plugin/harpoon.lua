require('harpoon').setup({
  menu = {
    width = (function()
      local width = vim.api.nvim_win_get_width(0) - 4;
      return math.floor(width - width * 0.55);
    end)(),
  }
})

local nnoremap = require("benlubas.keymap").nnoremap
local inoremap = require("benlubas.keymap").inoremap

local silent = { silent = true }

-- stole these from prime. they work well enough for me
nnoremap("<C-a>", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)

-- I can't use <C-'> as a bind, so using hjkl instead. I really like these.
nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<C-j>", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<C-k>", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<C-l>", function() require("harpoon.ui").nav_file(4) end, silent)

inoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
inoremap("<C-j>", function() require("harpoon.ui").nav_file(2) end, silent)
inoremap("<C-k>", function() require("harpoon.ui").nav_file(3) end, silent)
inoremap("<C-l>", function() require("harpoon.ui").nav_file(4) end, silent)

-- this isn't really a harpoon bind, but it's in the same spirit.
nnoremap("<leader><leader>n", ":e ~/github/notes/deadlines.md<CR>")
