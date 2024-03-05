local Hydra = require("hydra")

local options_hint = [[

  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _l_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  _c_ %{con} conceal
  _t_ %{twe} textwidth (%{tw})
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
        title = " Options Hydra ",
        title_pos = "center",
      },
      funcs = {
        ["twe"] = function()
          if vim.o.textwidth == 0 then
            return "[ ]"
          else
            return "[x]"
          end
        end,
        ["tw"] = function()
          return vim.o.textwidth
        end,
      },
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
