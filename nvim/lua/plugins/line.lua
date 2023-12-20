-- local hydra = function()
--   local hint = require("hydra.statusline").get_hint()
--   if hint == nil then
--     return ""
--   end
--   return hint
-- end

-- still TODO:
-- [x] Add search_count back
-- [ ] Add hydra back (and ideally change the entire bar so that it's showing the 'mode' as "HYDRA"
-- or something like that. I think that would be cool)
-- [ ] tmux bar to make it look more consistent?
-- [x] Add molten status back

return {
  {
    "MunifTanjim/nougat.nvim",
    dependencies = {
      "benlubas/molten-nvim",
    },
    config = function()
      local nougat = require("nougat")
      local core = require("nougat.core")
      local Bar = require("nougat.bar")
      local Item = require("nougat.item")
      local sep = require("nougat.separator")

      local color = require("moonfly").palette

      local default_highlight = {
        normal = { bg = color.blue, fg = "bg" },
        visual = { bg = color.purple, fg = "bg" },
        insert = { bg = color.normal, fg = "bg" },
        replace = { bg = color.crimson, fg = "bg" },
        commandline = { bg = color.khaki, fg = "bg" },
        terminal = { bg = color.orchid, fg = "bg" },
        inactive = { bg = color.grey, fg = "bg" },
      }

      local nut = {
        buf = {
          diagnostic_count = require("nougat.nut.buf.diagnostic_count").create,
          filename = require("nougat.nut.buf.filename").create,
          filestatus = require("nougat.nut.buf.filestatus").create,
          filetype = require("nougat.nut.buf.filetype").create,
        },
        git = {
          branch = require("nougat.nut.git.branch").create,
          status = require("nougat.nut.git.status"),
        },
        mode = require("nougat.nut.mode").create,
        spacer = require("nougat.nut.spacer").create,
        truncation_point = require("nougat.nut.truncation_point").create,
      }

      local stl = Bar("statusline")
      stl:add_item(nut.mode({
        config = { highlight = default_highlight },
        prefix = " ",
        suffix = " ",
        sep_right = sep.right_lower_triangle_solid(true),
      }))
      stl:add_item(nut.git.branch({
        hl = { fg = color.blue, bg = color.grey236 },
        prefix = "  ",
        suffix = " ",
        sep_right = sep.left_upper_triangle_solid(true),
      }))
      stl:add_item(nut.git.status.create({
        hl = { bg = color.grey233 },
        suffix = " ",
        sep_right = sep.right_upper_triangle_solid(true),
        content = {
          nut.git.status.count("added", {
            hl = { fg = color.emerald },
            prefix = " +",
          }),
          nut.git.status.count("changed", {
            hl = { fg = color.blue },
            prefix = " ~",
          }),
          nut.git.status.count("removed", {
            hl = { fg = color.red },
            prefix = " -",
          }),
        },
      }))
      stl:add_item(nut.buf.filename({
        prefix = " ",
        suffix = " ",
        config = {
          modifier = ":p",
        }
      }))

      stl:add_item(Item({
        hl = { bg = color.grey233, fg = color.orchid },
        content = function(_)
          return require("benlubas.search_count").get_search_count()
        end,
        prefix = " ",
        suffix = " ",
        sep_left = sep.left_lower_triangle_solid(true),
        sep_right = sep.right_upper_triangle_solid(true),
      }))

      stl:add_item(nut.spacer())
      stl:add_item(nut.truncation_point())

      stl:add_item(nut.buf.diagnostic_count({
        sep_left = sep.left_lower_triangle_solid(true),
        prefix = " ",
        suffix = " ",
        config = {
          error = { prefix = " " },
          warn = { prefix = " " },
          info = { prefix = " " },
          hint = { prefix = "󰌶 " },
        },
      }))
      stl:add_item(Item({
        hl = { bg = color.grey233, fg = color.red },
        sep_left = sep.left_lower_triangle_solid(true),
        prefix = " ",
        content = function(_)
          local s = require("molten.status").kernels()
          if s == vim.NIL then -- nougat can't handle this. I think that's probably a bug.
            return ""
          end
          return s
        end,
        suffix = " ",
        -- sep_right = sep.right_lower_triangle_solid(true),
      }))
      stl:add_item(nut.buf.filetype({
        hl = { bg = "#4e4e4e" },
        sep_left = sep.left_lower_triangle_solid(true),
        prefix = " ",
        suffix = " ",
      }))
      stl:add_item(Item({
        hl = { link = color.blue },
        sep_left = sep.left_lower_triangle_solid(true),
        prefix = " ",
        content = core.group({
          core.code("l"),
          ":",
          core.code("c"),
        }),
        suffix = " ",
      }))
      stl:add_item(Item({
        hl = { bg = color.blue, fg = color.grey235 },
        sep_left = sep.left_lower_triangle_solid(true),
        prefix = " ",
        content = core.code("P"),
        suffix = " ",
      }))

      nougat.set_statusline(stl)
    end,
  },
}

-- old lualine (was really annoying to get custom separators to behave the way I wanted)
-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     dependencies = { "nvim-tree/nvim-web-devicons" },
--     cond = not MarkdownMode(),
--     config = function()
--       require("lualine").setup({
--         options = {
--           theme = "auto",
--           icons_enabled = true,
--           disabled_filetypes = {
--             statusline = {},
--             winbar = {},
--           },
--           ignore_focus = {},
--           always_divide_middle = true,
--           globalstatus = true,
--           refresh = {
--             statusline = 1000,
--             tabline = 1000,
--             winbar = 1000,
--           },
--         },
--         sections = {
--           lualine_a = { { "mode", separator = { right = "" } } },
--           lualine_b = {
--             { "branch", separator = { left = "", right = "" } },
--             -- MoonflyCrimsonLine xxx guifg=#ff5189 guibg=#303030
--             -- MoonflyEmeraldLine xxx guifg=#36c692 guibg=#303030
--             -- MoonflyGrey246Line xxx guifg=#949494 guibg=#1c1c1c
--             -- MoonflyYellowLine xxx guifg=#e3c78a guibg=#1c1c1c
--             -- MoonflyBlueLineActive xxx guifg=#80a0ff guibg=#444444
--             -- MoonflyRedLineActive xxx guifg=#ff5454 guibg=#444444
--             -- MoonflyWhiteLineActive xxx guifg=#e4e4e4 guibg=#444444
--             -- MoonflyYellowLineActive xxx guifg=#e3c78a guibg=#444444
--             {
--               "diff",
--               diff_color = {
--                 added = "MoonflyEmerald",
--                 modified = "MoonflySky",
--                 removed = "MoonflyRed",
--               },
--               separator = { left = "", right = "" },
--             },
--             {
--               "diagnostics",
--               separator = { left = "", right = "" },
--             },
--           },
--           lualine_c = {
--             { "filename", path = 1 },
--             require("benlubas.search_count").get_search_count,
--             hydra,
--           },
--           lualine_x = {
--             "encoding",
--             "fileformat",
--             -- require('molten.status').initialized,
--             require("molten.status").kernels,
--             -- require('molten.status').all_kernels,
--             "filetype",
--           },
--           lualine_y = { "progress" },
--           lualine_z = { "location" },
--         },
--         inactive_sections = {
--           lualine_a = {},
--           lualine_b = {},
--           lualine_c = { "filename" },
--           lualine_x = { "location" },
--           lualine_y = {},
--           lualine_z = {},
--         },
--       })
--     end,
--   },
-- }
