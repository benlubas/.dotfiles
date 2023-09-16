return {
  {
    "goolord/alpha-nvim",
    dependencies = { "benlubas/harpoon" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local path = require("plenary.path")
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
            local short_name = path.new(file_name):shorten(3, { 1, -1, -2 })
            tbl[i] = dashboard.button(("%d"):format(i), short_name, (":e %s<CR>"):format(file_name))
          end
        end

        if #tbl == 0 then
          tbl = {
            dashboard.button("CTRL e", "Open Menu"),
            { type = "padding", val = 1 },
            dashboard.button("CTRL s", "Mark File"),
          }
        end
        return tbl
      end

      local harpoon_section = {
        type = "group",
        val = {
          {
            type = "text",
            val = "↽  Harpoon  ⇁",
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
        dashboard.button("e", "  New file", ":ene<CR>"),
        dashboard.button("SPC f d", "  File Search"),
        dashboard.button("-", "󰙅  Oil"),
        dashboard.button("c", "  Config", ":cd ~/github/.dotfiles<CR>"),
        dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
      }

      local conf = {
        layout = {
          { type = "padding", val = 2 },
          dashboard.section.header,
          { type = "padding", val = 1 },
          { type = "text", val = vim.fn.getcwd(), opts = { position = "center", hl = "SpecialComment" } },
          { type = "padding", val = 1 },
          dashboard.section.buttons,
          { type = "padding", val = 1 },
          harpoon_section,
          { type = "padding", val = 1 },
          { type = "text", val = "" .. math.random(), opts = { position = "center", hl = "Statement" } },
        },
        opts = {
          margin = 5,
          noautocmd = true,
        },
      }

      alpha.setup(conf)
    end,
  },
}
