local function harpoon_marks()
  local marks = require("harpoon").get_mark_config().marks
  local tbl = {}
  if marks then
    for i, mark in ipairs(marks) do
      if i > 4 then
        break
      end
      local file_name = P(mark.filename)
      local tail = file_name:match("^.+/(.+)$")
      if tail == nil then
        tail = file_name
      end
      tbl[i] = {
        action = function()
          require("harpoon.ui").nav_file(i)
        end,
        name = tail .. " (" .. file_name .. ")",
        section = "Harpoon",
      }
    end
  end

  return tbl
end

return {
  {
    {
      "echasnovski/mini.starter",
      dependencies = { "benlubas/harpoon" },
      version = "*",
      config = function()
        local starter = require("mini.starter")

        -- highlights
        vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { link = "MoonflyCrimson" })

        vim.api.nvim_set_hl(0, "MiniStarterCurrent", { link = "MoonflyBlueLineActive" })
        vim.api.nvim_set_hl(0, "MiniStarterFooter", { link = "MoonflyGrey239" })
        vim.api.nvim_set_hl(0, "MiniStarterHeader", { link = "MoonflyGrey237" })
        vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { link = "MoonflyKhaki" })
        vim.api.nvim_set_hl(0, "MiniStarterSection", { link = "MoonflyBlue" })
        vim.api.nvim_set_hl(0, "MiniStarterQuery", { link = "MoonflyBlue" })

        starter.setup({
          -- perform action when there's only one matching item
          evaluate_single = false,

          items = {
            harpoon_marks,
            starter.sections.recent_files(8, true), -- current directory
          },

          -- Header to be displayed before items. Converted to single string via
          -- `tostring` (use `\n` to display several lines). If function, it is
          -- evaluated first. If `nil` (default), polite greeting will be used.
          header = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████]],

          footer = nil,

          -- Array  of functions to be applied consecutively to initial content.
          -- Each function should take and return content for 'Starter' buffer (see
          -- |mini.starter| and |MiniStarter.content| for more details).
          content_hooks = {
            starter.gen_hook.adding_bullet("> "),
            starter.gen_hook.aligning("center", "center"),
          },

          -- this is default - the "-" so I can get to oil
          query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
        })
      end,
    },
  },
}
