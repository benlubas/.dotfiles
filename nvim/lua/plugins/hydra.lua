return {
  -- "nvimtools/hydra.nvim",
  -- dev = true,
  "benlubas/hydra.nvim",
  branch = "readme_overhaul",
  config = function()
    vim.api.nvim_set_hl(0, "HydraRed", { link = "MoonflyRed" })
    vim.api.nvim_set_hl(0, "HydraBlue", { link = "MoonflySky" })
    vim.api.nvim_set_hl(0, "HydraAmaranth", { link = "MoonflyCranberry" })
    vim.api.nvim_set_hl(0, "HydraTeal", { link = "MoonflyTurquoise" })
    vim.api.nvim_set_hl(0, "HydraPink", { link = "MoonflyCrimson" })

    local colors = require("moonfly").palette
    vim.api.nvim_set_hl(0, "HydraHint", { bg = colors.grey234 })
    vim.api.nvim_set_hl(0, "HydraBorder", { fg = colors.grey234 })
    vim.api.nvim_set_hl(0, "HydraTitle", { fg = colors.black, bg = colors.blue })
    vim.api.nvim_set_hl(0, "HydraFooter", { fg = colors.black, bg = colors.red })

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
        color = "pink",
        exit = true,
        invoke_on_body = true,
        hint = {
          position = "middle",
          float_opts = {
            border = Border,
            title = " Telescope hydra ",
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
              prompt_prefix = "~/notes/"
            })
          end,
          { exit = true },
        },
        { "m", require("benlubas.telescope.harpoon").harpoon_branch_marks_picker, { exit = true } },
        { "f", tb.resume,                                                         { exit = true } },
        { "h", "<cmd>Telescope help_tags<CR>",                                    { exit = true } },
        { "r", tb.pickers,                                                        { exit = true } },
        {
          "<Enter>",
          function()
            vim.cmd("Telescope")
          end,
        },
        { "<Esc>", nil, { exit = true, nowait = true } },
      },
    })

    local options_hint = [[

  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _l_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _c_ %{con} conceal
  _t_ %{txtw} textwidth
  ^
       ^^^^                _<Esc>_
]]

    Hydra({
      name = "Options",
      hint = options_hint,
      config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
          position = "middle",
          float_opts = {
            border = Border,
            title = " Options Hydra ",
            title_pos = "center",
          },
          funcs = {
            ["txtw"] = function()
              if vim.o.textwidth == 0 then
                return "[ ]"
              else
                return "[x]"
              end
            end
          }
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
            local maps = {
              { "n", "j", "gj" },
              { "n", "k", "gk" },
              { "n", "$", "g$" },
              { "n", "_", "g0" },
              { "n", "0", "g0" },
              { "v", "j", "gj" },
              { "v", "k", "gk" },
              { "v", "$", "g$" },
              { "v", "_", "g0" },
              { "v", "0", "g0" },
            }
            if vim.o.wrap ~= true then
              vim.o.wrap = true
              for _, map in ipairs(maps) do
                vim.keymap.set(map[1], map[2], map[3])
              end
            else
              vim.o.wrap = false
              for _, map in ipairs(maps) do
                pcall(vim.keymap.del, map[1], map[2])
              end
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
          function()
            if vim.o.conceallevel == 0 then
              vim.o.conceallevel = 1
            else
              vim.o.conceallevel = 0
            end
          end,
        },
        {
          "t",
          function()
            if vim.o.textwidth == 0 then
              vim.o.textwidth = 100
            else
              vim.o.textwidth = 0
            end
          end,
        },
        { "<Esc>", nil, { exit = true } },
      },
    })
  end,
}
