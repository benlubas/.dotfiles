return {
  "nvim-neorg/neorg",
  dev = true,
  build = ":Neorg sync-parsers",
  ft = "norg",
  lazy = false,
  keys = {
    { "<leader>ni", ":Neorg index<CR>", desc = "Neorg Index", silent = true },
    { "<leader>ns", ":e ~/notes/school/index.norg<CR>", desc = "Neorg School Index", silent = true },
    { "<leader>nw", ":e ~/notes/work/index.norg<CR>", desc = "Neorg Work Index", silent = true },
    { "<leader>nt", ":e ~/notes/tools/index.norg<CR>", desc = "Neorg Tools Index", silent = true },
    { "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>", desc = "New Note", silent = true },
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
  dependencies = {
    { "pysan3/neorg-templates", dev = true, dependencies = { "L3MON4D3/LuaSnip" } },
    { "nvim-lua/plenary.nvim" },
    { "nvim-neorg/neorg-telescope" },
    { "3rd/image.nvim" },
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.refactor"] = {},
        ["core.defaults"] = {},
        ["core.esupports.metagen"] = {
          config = {
            undojoin_updates = true,
          },
        },
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              -- Map \c to edit the code block in another buffer.
              keybinds.remap_event("norg", "n", "<localleader>l", "core.looking-glass.magnify-code-block")
              keybinds.map("norg", "n", "<localleader>R", ":Neorg return<CR>")
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
            },
          },
        },
        ["core.highlights"] = {
          config = {
            highlights = {
              headings = {
                ["1"] = { title = "+MoonflyCrimson", prefix = "+MoonflyCrimson" },
                ["2"] = { title = "+MoonflyBlue", prefix = "+MoonflyBlue" },
                ["3"] = { title = "+MoonflyKhaki", prefix = "+MoonflyKhaki" },
                ["4"] = { title = "+MoonflyOrchid", prefix = "+MoonflyOrchid" },
                ["5"] = { title = "+MoonflyCoral", prefix = "+MoonflyCoral" },
                ["6"] = { title = "+MoonflyEmerald", prefix = "+MoonflyEmerald" },
              },
            },
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
              TODAY = function()
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
              DESC = function()
                local i = require("luasnip").insert_node
                return i(1)
              end,
              RATING = function()
                local i = require("luasnip").insert_node
                return i(1)
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
        ["core.summary"] = {},
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
              test_notes = "~/test_notes",
            },
            default_workspace = "test_notes",
          },
        },
        ["core.integrations.telescope"] = {},
        -- NOTE: these require nvim 0.10 (nightly at the time of writing)
        -- ["core.ui.calendar"] = {},
        -- ["core.integrations.image"] = {},
        -- ["core.latex.renderer"] = {},
      },
    })
    local neorg_callbacks = require("neorg.core.callbacks")

    ---@diagnostic disable-next-line: missing-parameter
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

    local file_exists_and_is_empty = function(filepath)
      local file = io.open(filepath, "r") -- Open the file in read mode
      if file ~= nil then
        local content = file:read("*all") -- Read the entire content of the file
        file:close() -- Close the file
        return content == "" -- Check if the content is empty
      else
        return false
      end
    end

    vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
      callback = function(args)
        local toc = "index.norg"

        vim.schedule(function()
          if vim.fn.fnamemodify(args.file, ":t") == toc then
            return
          end
          if args.event == "BufNewFile" or (args.event == "BufNew" and file_exists_and_is_empty(args.file)) then
            vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", "journal" } }, {})
          end
        end)
      end,
      desc = "Load new workspace entries with a Neorg template",
      pattern = "*/notes/journal/*.norg",
    })
  end,
}
