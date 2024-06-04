-- from ./../benlubas/neorg/extras.norg
local extras = require("benlubas.neorg.extras")

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "nvim-neorg/neorg",
    dev = true,
    lazy = false,
    cond = not MarkdownMode(),
    dependencies = {
      { "luarocks.nvim" },
      { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope", dev = true },
      { "benlubas/neorg-conceal-wrap", dev = true },
      { "image.nvim" },
      { "otter.nvim" },
    },
    keys = {
      { "<leader>ni", ":Neorg index<CR>", desc = "Neorg Index", silent = true },
      { "<leader>ns", ":e ~/notes/school/index.norg<CR>", desc = "Neorg School Index", silent = true },
      { "<leader>nw", ":e ~/notes/work/index.norg<CR>", desc = "Neorg Work Index", silent = true },
      { "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>", desc = "New Note", silent = true },
      { "<leader>nt", extras.new_thought, desc = "New Thought", silent = true },
      { "<leader>np", extras.project_note, desc = "Project Note", silent = true },
      {
        "<A-CR>",
        ":Neorg keybind norg core.itero.next-iteration<CR>",
        desc = "next iteration",
        silent = true,
        mode = "i",
      },
      { "<leader>jt", ":Neorg journal today<CR>", desc = "Journal Today", silent = true },
      { "<leader>jy", ":Neorg journal yesterday<CR>", desc = "Journal Yesterday", silent = true },
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
        ["core.refactor"] = {},
        ["external.conceal-wrap"] = {},
        ["core.integrations.otter"] = {
          config = {
            auto_start = false,
            languages = { "python", "lua" },
            keys = {
              hover = "H",
              definition = "gd",
              type_definition = "gt",
              references = "gr",
              rename = "<leader>rn",
              format = "<leader>gf",
              document_symbols = "gs",
            },
          },
        },
        ["core.defaults"] = {},
        ["core.text-objects"] = {},
        ["core.tangle"] = {
          config = {
            tangle_on_write = true,
          },
        },
        ["core.esupports.metagen"] = {
          config = {
            undojoin_updates = true,
            type = "empty",
          },
        },
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.integrations.telescope"] = {},
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              -- Map \c to edit the code block in another buffer.
              keybinds.remap_event("norg", "n", "<localleader>l", "core.looking-glass.magnify-code-block")
              keybinds.map("norg", "n", "<localleader>R", ":Neorg return<CR>")
              keybinds.map("traverse-heading", "n", "<esc>", ":Neorg mode norg<CR>")
              keybinds.map("norg", "n", "<localleader>nm", ":Neorg inject-metadata<CR>")
              keybinds.map("norg", "n", "<localleader>c", "ocode<C-j>", { remap = true })
              keybinds.map("norg", "n", "u", function()
                require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
                local k = vim.api.nvim_replace_termcodes("u<c-o>", true, false, true)
                vim.api.nvim_feedkeys(k, "n", false)
              end)
              keybinds.map("norg", "n", "U", function()
                require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
                local k = vim.api.nvim_replace_termcodes("<c-r><c-o>", true, false, true)
                vim.api.nvim_feedkeys(k, "n", false)
              end)
              keybinds.map("norg", "i", "-(", "- ( ) ")
              keybinds.remap_event("norg", "n", "<localleader>d", "core.tempus.insert-date")
              keybinds.remap_event("norg", "i", "\\date", "core.tempus.insert-date-insert-mode")
              keybinds.unmap("norg", "n", "gd")

              keybinds.remap_event("norg", { "o", "x" }, "iT", "core.text-objects.textobject.tag.inner")

              keybinds.remap_event("norg", "n", "<up>", "core.text-objects.item_up")
              keybinds.remap_event("norg", "n", "<down>", "core.text-objects.item_down")
            end,
          },
        },
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
      if vim.version.gt(vim.version(), "0.9.5") then
        load["core.ui.calendar"] = {}
        load["core.math.renderer"] = {}
        load["core.math.renderer.latex"] = {}
      end
      require("neorg").setup({ load = load })

      local neorg_callbacks = require("neorg.core.callbacks")

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          n = { -- Bind keys in normal mode
            { "<localleader>fl", "core.integrations.telescope.find_linkable" },
            { "<localleader>fb", "core.integrations.telescope.find_backlinks" },
            { "<localleader>fh", "core.integrations.telescope.find_header_backlinks" },
          },

          i = { -- Bind in insert mode
            { "<localleader>li", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)

      extras.template("*/notes/journal/*.norg", "journal")
      extras.template("*/notes/thoughts/*.norg", "thought")
    end,
  },
}
