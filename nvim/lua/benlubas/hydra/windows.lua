local Hydra = require("hydra")

local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ ^ _K_ ^ ^    ^   _+_   ^      _s_: horizontally
 _h_ ^ ^ _l_  ^ _H_ ^ ^ _L_    _<_     _>_      _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ ^ _J_ ^ ^    ^   _-_   ^      _q_: close
 focus^^^^^^  ^window^^^^  ^^^_=_: equalize ^   _z_: max height
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^ ^  ^^ ^           ^   _x_: max width
 ^ _b_: choose buffer ^ ^^^ ^ ^ ^ ^ ^ ^ ^^ ^^   _o_: remain only
]]

Hydra({
  name = "Windows",
  hint = window_hint,
  config = {
    invoke_on_body = true,
  },
  mode = "n",
  body = "<C-w>",
  heads = {
    { "h", "<C-w>h" },
    { "j", "<C-w>j" },
    { "k", "<C-w>k" },
    { "l", "<C-w>l" },

    { "H", "<C-w>H" },
    { "J", "<C-w>J" },
    { "K", "<C-w>K" },
    { "L", "<C-w>L" },

    { "<", "<C-w><" },
    { "-", "<C-w>-" },
    { "+", "<C-w>+" },
    { ">", "<C-w>>" },
    { "=", "<C-w>=", { desc = "equalize" } },

    { "s", "<C-w>s" },
    { "v", "<C-w>v" },

    { "w", "<C-w>w", { exit = true, desc = false } },
    { "<C-w>", "<C-w>w", { exit = true, desc = false } },
    { "z", "<c-w>_", { desc = "maximize height" } },
    { "x", "<c-w>|", { desc = "maximize width" } },
    { "o", "<C-w>o", { exit = true, desc = "remain only" } },

    {
      "b",
      function() require("benlubas.telescope.project-files").project_files() end,
      { exit = true, desc = "choose buffer" },
    },

    { "q", ":q<CR>", { desc = "close window" } },

    { "<Esc>", nil, { exit = true, desc = false } },
  },
})
