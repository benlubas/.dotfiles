return {
  {
    {
      "echasnovski/mini.starter",
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
            starter.sections.recent_files(6, true), -- current directory
            starter.sections.recent_files(6, false),
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
        })
      end,
    },
  },
}
