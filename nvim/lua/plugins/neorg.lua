return {
  "nvim-neorg/neorg",
  -- dev = true,
  build = ":Neorg sync-parsers",
  ft = "norg",
  keys = {
    { "<leader>ni", ":Neorg index<CR>",                             desc = "Neorg Index",        silent = true },
    { "<leader>ns", ":e ~/notes/school/index.norg<CR>",             desc = "Neorg School Index", silent = true },
    { "<leader>nw", ":e ~/notes/work/index.norg<CR>",               desc = "Neorg Work Index",   silent = true },
    { "<leader>nt", ":e ~/notes/tools/index.norg<CR>",              desc = "Neorg Tools Index",  silent = true },
    { "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>", desc = "New Note",           silent = true },
    {
      "<A-CR>",
      ":Neorg keybind norg core.itero.next-iteration<CR>",
      desc = "next iteration",
      silent = true,
      mode = "i",
    },
    { "<leader>jt", ":Neorg journal today<CR>",     desc = "Journal Today",     silent = true },
    { "<leader>jy", ":Neorg journal yesterday<CR>", desc = "Journal Yesterday", silent = true },
  },
  dependencies = {
    { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              -- Map \c to edit the code block in another buffer.
              keybinds.remap_event("norg", "n", "<localleader>l", "core.looking-glass.magnify-code-block")
              keybinds.map("norg", "n", "<localleader>r", ":Neorg return<CR>")
              -- keybinds.map("norg", "n", "u", "uu")
              keybinds.map("norg", "n", "<localleader>nm", ":Neorg inject-metadata<CR>")
              keybinds.map("norg", "n", "<localleader>c", "icode<C-j>", { remap = true })
              keybinds.remap_event("norg", "n", "<localleader>d", "core.tempus.insert-date")
              keybinds.remap_event("norg", "i", "/date", "core.tempus.insert-date-insert-mode")
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
        ["core.journal"] = {
          config = {
            -- NOTE: I'm using the journal for work only. You can have multiple journals.
            -- But I'm just planning to switch this config option when I'm no longer working if
            -- I still need a journal.
            workspace = "work",
          },
        },
        ["external.templates"] = {
          config = {
            templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
            default_subcommand = "load", -- or "fload", "load"
            keywords = {
              TODAY = function()
                return require("luasnip").text_node(os.date("%A %B %d, %Y"))
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
              SLEEP = function()
                local i = require("luasnip").insert_node
                return i(1)
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
        -- NOTE: this requires nvim 10 (nightly at the time of writing)
        -- ["core.ui.calendar"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              work = "~/notes/work",
              school = "~/notes/school",
              tools = "~/notes/tools",
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    })

    local file_exists_and_is_empty = function(filepath)
      local file = io.open(filepath, "r") -- Open the file in read mode
      if file ~= nil then
        local content = file:read("*all") -- Read the entire content of the file
        file:close()                      -- Close the file
        return content == ""              -- Check if the content is empty
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
      pattern = "*/notes/*/journal/*.norg",
    })
  end,
}
