local function keys(str)
  return function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
  end
end

local Hydra = require("hydra")
Hydra({
  name = "Notebook",
  hint = "_j_/_k_: ↑/↓ | _o_/_O_: new cell ↓/↑ | _l_: run | _s_how | _h_ide | run _a_bove | _q_uit",
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      type = "statuslinemanual",
    },
  },
  mode = { "n" },
  body = "<localleader>j",
  heads = {
    { "j", keys("]b"), { desc = "↓" } },
    { "k", keys("[b"), { desc = "↑" } },
    { "o", keys("/```<CR>:nohl<CR>o<CR>`<c-j>"), { desc = "new cell ↓", exit = true } },
    { "O", keys("?```.<CR>:nohl<CR><leader>kO<CR>`<c-j>"), { desc = "new cell ↑", exit = true } },
    { "l", ":QuartoSend<CR>", { desc = "run" } },
    { "s", ":noautocmd MoltenEnterOutput<CR>", { desc = "show" } },
    { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
    { "a", ":QuartoSendAbove<CR>", { desc = "run above" } },
    { "<esc>", nil, { exit = true, desc = false } },
    { "q", nil, { exit = true, desc = false } },
  },
})
