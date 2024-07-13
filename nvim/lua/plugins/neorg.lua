-- from ./../benlubas/neorg/extras.norg
local extras = require("benlubas.neorg.extras")

return {
  {
    "nvim-neorg/neorg",
    dev = true,
    lazy = false,
    cond = not MarkdownMode(),
    dependencies = {
      { "pysan3/neorg-templates",     dependencies = { "L3MON4D3/LuaSnip" } },
      { "nvim-neorg/neorg-telescope" },
      { "benlubas/neorg-conceal-wrap" },
      { "benlubas/neorg-interim-ls",  dev = true },
      { "benlubas/neorg-se" },
      { "image.nvim" },
      { "otter.nvim" },
    },
    keys = {
      { "<leader>ni", ":Neorg index<CR>",                 desc = "Neorg Index",        silent = true },
      { "<leader>ns", ":e ~/notes/school/index.norg<CR>", desc = "Neorg School Index", silent = true },
      { "<leader>nw", ":e ~/notes/work/index.norg<CR>",   desc = "Neorg Work Index",   silent = true },
      { "<leader>nn", "<Plug>(neorg.dirman.new-note)",    desc = "New Note",           silent = true },
      { "<leader>nt", extras.new_thought,                 desc = "New Thought",        silent = true },
      { "<leader>np", extras.project_note,                desc = "Project Note",       silent = true },
      { "<leader>jt", ":Neorg journal today<CR>",         desc = "Journal Today",      silent = true },
      { "<leader>jy", ":Neorg journal yesterday<CR>",     desc = "Journal Yesterday",  silent = true },
    },
    config = function()
      local theme = require("benlubas.color").neorg

      vim.api.nvim_set_hl(0, "NeorgH1", theme.heading1)
      vim.api.nvim_set_hl(0, "NeorgH2", theme.heading2)
      vim.api.nvim_set_hl(0, "NeorgH3", theme.heading3)
      vim.api.nvim_set_hl(0, "NeorgH4", theme.heading4)
      vim.api.nvim_set_hl(0, "NeorgH5", theme.heading5)
      vim.api.nvim_set_hl(0, "NeorgH6", theme.heading6)

      local load = {
        -- load["core.math.renderer"] = {}
        ["external.interim-ls"] = {
          config = {
            completion_provider = { categories = true },
          },
        },
        ["external.search"] = {},
        ["external.conceal-wrap"] = {},
        ["core.integrations.otter"] = {
          config = {
            auto_start = false,
            languages = { "python", "lua", "rust" },
          },
        },
        ["core.defaults"] = {},
        ["core.text-objects"] = {},
        ["core.tangle"] = {
          config = {
            tangle_on_write = true,
            indent_errors = "print",
            report_on_empty = false,
          },
        },
        ["core.esupports.metagen"] = {
          config = {
            undojoin_updates = true,
            type = "empty",
          },
        },
        ["core.qol.toc"] = {
          config = {
            enter = true,
            fixed_width = 26,
            auto_toc = {
              open = true,
              close = true,
              -- exit = false,
            },
          },
        },
        ["core.completion"] = {
          config = { engine = { module_name = "external.lsp-completion" } },
        },
        ["core.integrations.telescope"] = {},
        ["core.keybinds"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond",
            icons = {
              todo = {
                undone = {
                  icon = " ",
                },
              },
              heading = {
                icons = { "◆", "❖", "◈", "◇", "⟡", "⋄" },
              },
              code_block = {
                conceal = true,
                spell_check = false,
                content_only = false,
                width = "content",
                min_width = 85,
                highlight = "CodeCell",
              },
            },
          },
        },
        ["core.highlights"] = {
          config = {
            highlights = {
              headings = {
                ["1"] = { title = "+NeorgH1", prefix = "+NeorgH1" },
                ["2"] = { title = "+NeorgH2", prefix = "+NeorgH2" },
                ["3"] = { title = "+NeorgH3", prefix = "+NeorgH3" },
                ["4"] = { title = "+NeorgH4", prefix = "+NeorgH4" },
                ["5"] = { title = "+NeorgH5", prefix = "+NeorgH5" },
                ["6"] = { title = "+NeorgH6", prefix = "+NeorgH6" },
              },
            },
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
              test = "~/test_notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.journal"] = {
          config = {
            workspace = "notes",
            journals = {
              sprint = {
                period = { day = 14 },
                start_date = os.time({ year = 2024, month = 06, day = 17 }),
                path_format_strategy = function(date)
                  local sprint_number = math.floor(os.difftime(os.time(date),
                    os.time({ year = 2024, month = 06, day = 17 })) / 60 / 60 / 24 / 14) + 1
                  return ("work/sprints/sprint-%d_%d-%d-%d"):format(sprint_number, date.year, date.month, date.day)
                end,
              },
              daily = {
                start_date = os.time({ year = 2024, month = 06, day = 17, hour = 1 }),
              },
            },
          },
        },
        ["external.templates"] = {
          config = {
            templates_dir = vim.env.HOME .. "/notes/templates",
            default_subcommand = "load", -- or "fload", "load"
            keywords = {
              TODAY_TITLE = function()
                local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
                local date = os.date("%A %B %d, %Y", os.time({ year = buf[1], month = buf[2], day = buf[3] }))
                return require("luasnip").text_node(date)
              end,
              YESTERDAY_PATH = function()
                local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
                local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
                local yesterday = os.date("%Y/%m/%d", time - 86400)
                return require("luasnip").text_node(("../../%s"):format(yesterday))
              end,
              TOMORROW_PATH = function()
                local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
                local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
                local tomorrow = os.date("%Y/%m/%d", time + 86400)
                return require("luasnip").text_node(("../../%s"):format(tomorrow))
              end,
              CARRY_OVER_TODOS = function()
                -- local todos = table.concat(get_carryover_todos(), "\n")
                return require("luasnip").text_node(extras.get_carryover_todos())
              end,
              INSERT_2 = function()
                return require("luasnip").insert_node(1)
              end,
              INSERT_3 = function()
                return require("luasnip").insert_node(1)
              end,
              INSERT_4 = function()
                return require("luasnip").insert_node(1)
              end,
              WEATHER = function()
                local c = require("luasnip").choice_node
                local t = require("luasnip").text_node
                return c(1, { t("Sun"), t("Rain"), t("Storm"), t("Snow"), t("Clouds") })
              end,
            },
            snippets_overwrite = {},
          },
        },
      }
      require("neorg").setup({ load = load })

      extras.template("*/notes/journal/*.norg", "journal", ".*/notes/journal/%d%d%d%d/%d%d/%d%d%.norg")
      extras.template("*/notes/thoughts/*.norg", "thought")
    end,
  },
}
