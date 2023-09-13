return {
  "benlubas/hydra.nvim",
  config = function()
    local hydra = require("hydra")
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
    hydra({
      name = "Telescope",
      hint = hint,
      config = {
        color = "pink",
        exit = true,
        invoke_on_body = true,
        hint = {
          position = "middle",
          border = "rounded",
        },
      },
      mode = "n",
      body = "<leader>f",
      heads = {
        { "d", require("benlubas.telescope.project-files").project_files, { exit = true, nowait = true } },
        { "a", function() vim.cmd("Telescope live_grep") end,   {  exit = true } },
        { ".", function() tb.find_files({ hidden = true }) end, {  exit = true } },
        { "j", tb.current_buffer_fuzzy_find, { exit = true } },
        { "s", function() tb.git_status(require("telescope.themes").get_dropdown()) end, { exit = true } },
        { "l",
          function()
            local dir = vim.env.HOME .. "/github/.dotfiles"
            tb.find_files({
              find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir } })
          end,
          { exit = true },
        },
        { "n",
          function()
            local dir = vim.env.HOME .. "/notes"
            tb.find_files({ find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir } })
          end,
          { exit = true },
        },
        { "m", require("benlubas.telescope.harpoon").harpoon_branch_marks_picker, { exit = true} },

        { "f", tb.resume,                      { exit = true } },
        { "h", "<cmd>Telescope help_tags<CR>", { exit = true } },
        { "r", tb.pickers,                     { exit = true } },
        { "<Enter>", function() vim.cmd("Telescope") end },
        { "<Esc>",   nil,                            { exit = true, nowait = true } },
      },
    })

    local options_hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _l_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _c_ %{con} conceal
  ^
       ^^^^                _<Esc>_
]]

    hydra({
      name = "Options",
      hint = options_hint,
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          position = "middle",
          border = "rounded",
        },
      },
      mode = { "n" },
      body = "<leader><leader>o",
      heads = {
        {
          "n",
          function()
            if vim.o.number == true then
              vim.o.number = false
            else
              vim.o.number = true
            end
          end,
        },
        {
          "r",
          function()
            if vim.o.relativenumber == true then
              vim.o.relativenumber = false
            else
              vim.o.number = true
              vim.o.relativenumber = true
            end
          end,
        },
        {
          "v",
          function()
            if vim.o.virtualedit == "all" then
              vim.o.virtualedit = "block"
            else
              vim.o.virtualedit = "all"
            end
          end,
        },
        {
          "i",
          function()
            if vim.o.list == true then
              vim.o.list = false
            else
              vim.o.list = true
            end
          end,
        },
        {
          "s",
          function()
            if vim.o.spell == true then
              vim.o.spell = false
            else
              vim.o.spell = true
            end
          end,
        },
        {
          "w",
          function()
            if vim.o.wrap ~= true then
              vim.o.wrap = true
            else
              vim.o.wrap = false
            end
          end,
        },
        {
          "l",
          function()
            if vim.o.cursorline == true then
              vim.o.cursorline = false
            else
              vim.o.cursorline = true
            end
          end,
        },
        {
          "c",
          function ()
            if vim.o.conceallevel == 0 then
              vim.o.conceallevel = 1
            else
              vim.o.conceallevel = 0
            end
          end,
        },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}
