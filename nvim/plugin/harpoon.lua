require('harpoon').setup()

local nnoremap = require("benlubas.keymap").nnoremap

local silent = { silent = true }

-- stole these from prime. they work well enough for me
nnoremap("<leader>a", function() require("harpoon.mark").add_file() end, silent)
nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, silent)

-- I can't use <C-'> as a bind, so using hjkl instead. I really like these.
nnoremap("<C-h>", function() require("harpoon.ui").nav_file(1) end, silent)
nnoremap("<C-j>", function() require("harpoon.ui").nav_file(2) end, silent)
nnoremap("<C-k>", function() require("harpoon.ui").nav_file(3) end, silent)
nnoremap("<C-l>", function() require("harpoon.ui").nav_file(4) end, silent)

nnoremap("<leader>j", ":!tmux select-window -t 0<CR><CR>", silent) -- okay, this just works lol.
nnoremap("<leader>k", ":!tmux select-window -t 2<CR><CR>", silent)

-- tmux navigation.. 
-- I want to be able to get to the notes window really quickly, and just open my file... are harpoon 
-- binds terminal specific? or if I open another nvim will they be copied. I kinda don't want them 
-- to get copied over, that would be a little annoying.

-- Okay, I don't think it likes having two nvim instances open at the same time... 
-- that's a little bit annoying, but honestly... I can probably just jump to notes in this nvim 
-- if it's so easy to get back.. you know?
