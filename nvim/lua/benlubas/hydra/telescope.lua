local Hydra = require("hydra")

local hint = [[

  _d_: files              _a_: live grep
  _._: all + .files       _j_: current buffer fuzzy find
  _s_: modified files     _l_: ~/dotfiles
  _n_: ~/notes            _m_: harpoon marks
  ^
  _f_: resume last search _h_: help
  _r_: recent pickers
 ^
  _<Enter>_: Telescope           _<Esc>_
]]

local tb = require("telescope.builtin")
Hydra({
  name = "Telescope",
  hint = hint,
  config = {
    color = "blue",
    exit = true,
    invoke_on_body = true,
    hint = {
      position = "middle",
      float_opts = {
        title = " Telescope Hydra ",
        title_pos = "center",
      },
    },
  },
  mode = "n",
  body = "<leader>f",
  heads = {
    { "d", require("benlubas.telescope.project-files").project_files, { exit = true, nowait = true } },
    { "a", tb.live_grep,                                              { exit = true } },
    {
      ".",
      function()
        tb.find_files({ hidden = true })
      end,
      { exit = true },
    },
    { "j", tb.current_buffer_fuzzy_find, { exit = true } },
    { "s", tb.git_status,                { exit = true } },
    {
      "l",
      function()
        local dir = vim.env.HOME .. "/github/.dotfiles"
        tb.find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
          prompt_prefix = "~/.dotfiles/",
        })
      end,
      { exit = true },
    },
    {
      "n",
      function()
        local dir = vim.env.HOME .. "/notes"
        tb.find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
          prompt_prefix = "~/notes/",
        })
      end,
      { exit = true },
    },
    { "m", require("benlubas.telescope.harpoon").harpoon_branch_marks_picker, { exit = true } },
    { "f", tb.resume,                                                         { exit = true } },
    { "h", "<cmd>Telescope help_tags<CR>",                                    { exit = true } },
    { "r", tb.pickers,                                                        { exit = true } },
    { "<Enter>", function() vim.cmd("Telescope") end, { exit = true }, },
    { "<Esc>", nil, { exit = true, nowait = true } },
  },
})
