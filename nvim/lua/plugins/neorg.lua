local function new_thought()
  vim.schedule(function()
    vim.ui.input({ default = "thoughts/" }, function(text)
      require("neorg.modules.core.dirman.module").public.create_file(text)
    end)
  end)
end

local function project_note()
  -- get the current directory
  local cwd = vim.fn.getcwd()
  local proj_name = cwd:match("github/(.*)")
  if not proj_name then
    vim.notify("[Neorg-Projects] Not in a project.")
    return
  end
  local prefix = "~/notes/projects/" .. proj_name
  local _, exists = io.open(prefix .. ".norg", "r")
  if exists then
    vim.cmd.e(prefix .. ".norg")
  else
    require("neorg.modules.core.dirman.module").public.create_file(prefix)
  end
end

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

local function template(pattern, template_name)
  vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
    desc = "Autoload template for notes/journal",
    pattern = pattern,
    callback = function(args)
      local index = "index.norg"

      vim.schedule(function()
        if vim.fn.fnamemodify(args.file, ":t") == index then
          return
        end
        if args.event == "BufNewFile" or (args.event == "BufNew" and file_exists_and_is_empty(args.file)) then
          vim.api.nvim_cmd({ cmd = "Neorg", args = { "templates", "fload", template_name } }, {})
        end
      end)
    end,
  })
end

local get_carryover_todos = function()
  -- local queryString = [[ (_
  --     state: (detached_modifier_extension [
  --       (todo_item_undone)
  --       (todo_item_pending)
  --     ])
  --     content: (paragraph)
  --   ) @something
  -- ]]
  --
  -- queryString = [[
  --     (heading2
  --       (heading2_prefix)
  --       title: (_)
  --       content: (generic_list
  --                  (unordered_list1
  --                    state: (_)
  --                    content: (_)
  --                  ) @list
  --                ))
  -- ]]
  --
  -- local todos = {}
  --
  -- local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
  -- local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
  -- local yesterday = os.date("%Y/%m/%d", time - 86400)
  -- local ws_path = require("neorg.modules.core.dirman.module").public.get_current_workspace()
  -- ws_path = ws_path[2]
  -- local yesterday_path = ws_path .. "/journal/" .. yesterday .. ".norg"
  -- local f = io.open(yesterday_path, "r")
  -- if not f then
  --   return {}
  -- end
  -- local content = f:read("*a")
  --
  -- local parser = vim.treesitter.get_string_parser(content, "norg")
  -- local tree = parser:parse()[1]
  -- local root = tree:root()
  -- local lang = parser:lang()
  -- local query = vim.treesitter.query.parse(lang, queryString)
  --
  -- local i = 0
  -- ---@diagnostic disable-next-line: missing-parameter
  -- for _, matches, _ in query:iter_matches(root, 0) do
  --   local m = vim.treesitter.get_node_text(matches[1], content)
  --   P("match:", m)
  --   m = m:match("^.*[^\n]")
  --   for _, line in ipairs(vim.split(m, "\n")) do
  --     if i > 0 then
  --       line = "   " .. line -- just hard coding the correct indent for me. idk how to dynamically set this
  --     end
  --     table.insert(todos, line)
  --   end
  --   i = i + 1
  -- end
  -- return todos

  -- For now I'm just going to leave it like this, the TS query doesn't seem to work..
  return ""
end

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001,
    opts = {},
  },
  {
    "nvim-neorg/neorg",
    dev = true,
    ft = "norg",
    lazy = false,
    dependencies = {
      { "luarocks.nvim" },
      { "pysan3/neorg-templates",    dev = true, dependencies = { "L3MON4D3/LuaSnip" } },
      { "nvim-lua/plenary.nvim" },
      { "nvim-neorg/neorg-telescope" },
      { "image.nvim" },
      { "otter.nvim" },
    },
    keys = {
      { "<leader>ni", ":Neorg index<CR>",                             desc = "Neorg Index",        silent = true },
      { "<leader>ns", ":e ~/notes/school/index.norg<CR>",             desc = "Neorg School Index", silent = true },
      { "<leader>nw", ":e ~/notes/work/index.norg<CR>",               desc = "Neorg Work Index",   silent = true },
      { "<leader>nn", ":Neorg keybind norg core.dirman.new.note<CR>", desc = "New Note",           silent = true },
      { "<leader>nt", new_thought,                                    desc = "New Thought",        silent = true },
      { "<leader>np", project_note,                                   desc = "Project Note",       silent = true },
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
    config = function()
      local theme = require("benlubas.color").neorg

      vim.api.nvim_set_hl(0, "NeorgH1", theme.heading1)
      vim.api.nvim_set_hl(0, "NeorgH2", theme.heading2)
      vim.api.nvim_set_hl(0, "NeorgH3", theme.heading3)
      vim.api.nvim_set_hl(0, "NeorgH4", theme.heading4)
      vim.api.nvim_set_hl(0, "NeorgH5", theme.heading5)
      vim.api.nvim_set_hl(0, "NeorgH6", theme.heading6)

      require("neorg").setup({
        load = {
          ["core.refactor"] = {},
          ["core.integrations.otter"] = {
            config = {
              auto_start = true,
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
          ["core.esupports.metagen"] = {
            config = {
              undojoin_updates = true,
              type = "empty",
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
                  return require("luasnip").text_node(P(get_carryover_todos()))
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
              default_workspace = "notes",
            },
          },
          ["core.integrations.telescope"] = {},
          -- NOTE: these require nvim 0.10 (nightly at the time of writing)
          ["core.ui.calendar"] = {},
          -- These two are broken.. not sure what's wrong
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

      template("*/notes/journal/*.norg", "journal")
      template("*/notes/thoughts/*.norg", "thought")
    end,
  },
}
