local hydra = function()
  local hint = require("hydra.statusline").get_hint()
  if hint == nil then
    return ""
  end
  return hint
end

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
      local common_left = {
        nut.git.status.create({
          hl = { bg = color.grey233 },
          suffix = " ",
          sep_right = sep.right_upper_triangle_solid(true),
          content = {
            nut.git.status.count("added", { hl = { fg = color.emerald }, prefix = " +" }),
            nut.git.status.count("changed", { hl = { fg = color.blue }, prefix = " ~" }),
            nut.git.status.count("removed", { hl = { fg = color.red }, prefix = " -" }),
          },
        }),
      }

      for _, item in ipairs(common_left) do
        stl:add_item(item)
      end

      stl:add_item(nut.buf.filename({
        prefix = " ",
        suffix = " ",
        config = {
          modifier = ":p",
          format = function(filename, _)
            return filename:gsub("^" .. vim.env.HOME, "~")
          end,
        },
      }))

      stl:add_item(nut.buf.filestatus({ prefix = "[", suffix = "] " }))

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

      local common_right = {
        Item({
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
        }),
        nut.buf.filetype({
          hl = { bg = "#4e4e4e" },
          sep_left = sep.left_lower_triangle_solid(true),
          prefix = " ",
          suffix = " ",
        }),
        Item({
          hl = { link = color.blue },
          sep_left = sep.left_lower_triangle_solid(true),
          prefix = " ",
          content = core.group({
            core.code("l"),
            ":",
            core.code("c"),
          }),
          suffix = " ",
        }),
        Item({
          hl = { bg = color.blue, fg = color.grey235 },
          sep_left = sep.left_lower_triangle_solid(true),
          prefix = " ",
          content = core.code("P"),
          suffix = " ",
        }),
      }

      for _, item in ipairs(common_right) do
        stl:add_item(item)
      end

      -- hydra status line
      local hsl = Bar("statusline")
      hsl:add_item(Item({
        hl = { bg = color.red, fg = color.black },
        prefix = " ",
        content = "HYDRA",
        suffix = " ",
        sep_right = sep.right_lower_triangle_solid(true),
      }))
      hsl:add_item(Item({
        hl = { fg = color.red, bg = color.grey236 },
        prefix = " ",
        content = require("hydra.statusline").get_name,
        suffix = " ",
        sep_right = sep.right_lower_triangle_solid(true),
      }))

      for _, item in ipairs(common_left) do
        hsl:add_item(item)
      end

      hsl:add_item(nut.spacer())
      hsl:add_item(Item({ prefix = " ", content = hydra, suffix = " " }))
      hsl:add_item(nut.spacer())

      for _, item in ipairs(common_right) do
        hsl:add_item(item)
      end

      nougat.set_statusline(function(_) -- context
        if require("hydra.statusline").is_active() then
          return hsl
        end
        return stl
      end)
    end,
  },
}
