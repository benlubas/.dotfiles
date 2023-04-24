return {
  {
    "goolord/alpha-nvim",
    dependencies = { "benlubas/harpoon" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local path = require('plenary.path')
      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
      }

      local function harpoon_files()
        local marks = require("harpoon").get_mark_config().marks
        local tbl = {}
        if marks then
          for i, mark in ipairs(marks) do
            local file_name = mark.filename
            local short_name = path.new(file_name):shorten(3)
            tbl[i] = dashboard.button(("%d"):format(i), short_name, (":e %s<CR>"):format(file_name))
          end
        end
        return tbl
      end

      local harpoon_section = {
        type = "group",
        val = {
          {
            type = "text",
            val = "↽  Harpoon Files  ⇁",
            opts = {
              hl = "SpecialComment",
              shrink_margin = false,
              position = "center",
            },
          },
          { type = "padding", val = 1 },
          {
            type = "group",
            val = harpoon_files,
            opts = { shrink_margin = false },
          },
          { type = "padding", val = 1 },
        },
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
      }

      local coinflip = ""
      if math.random() > 0.5 then
        coinflip = "heads"
      else
        coinflip = "tails"
      end

      local conf = {
        layout = {
          { type = "padding", val = 2 },
          dashboard.section.header,
          { type = "padding", val = 2 },
          dashboard.section.buttons,
          { type = "padding", val = 1 },
          harpoon_section,
          { type = "padding", val = 1 },
          { type = "text", val = coinflip, opts = { position = "center" } },
        },
        opts = {
          margin = 5,
          noautocmd = true,
        },
      }

      vim.cmd([[autocmd User AlphaReady echo 'ready']])

      alpha.setup(conf)
    end,
  },
}
