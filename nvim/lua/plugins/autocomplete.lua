-- File with all things related to auto complete (excluding the LSP server stuff itself)

-- Builtin completion (uncomment for testing)
-- vim.opt.omnifunc = vim.lsp.omnifunc

-- package.cpath = package.cpath .. ";/home/benlubas/github/blink.cmp/?.so"

-- return {
--   {
--     dir = "~/github/cmp2lsp",
--     enabled = false,
--     dependencies = {
--       { "hrsh7th/cmp-path" },
--       { "hrsh7th/cmp-buffer" },
--       { "hrsh7th/cmp-calc" },
--     },
--     event = "VeryLazy",
--     config = vim.schedule_wrap(function()
--       require("cmp2lsp").setup({
--         sources = {
--           { "calc",  "path" },
--           { "buffer" },
--         },
--       })
--     end),
--   },
--   {
--     "saghen/blink.cmp",
--     lazy = false,
--     version = "v0.*",
--
--     opts = {
--       keymap = {
--         ['<C-n>'] = { 'show', 'select_next', 'fallback' },
--         ['<C-e>'] = { 'hide', 'fallback' },
--         ['<C-y>'] = { 'select_and_accept' },
--
--         ['<C-p>'] = { 'select_prev', 'fallback' },
--
--         ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
--         ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
--       },
--
--       -- experimental auto-brackets support
--       accept = { auto_brackets = { enabled = true } },
--
--       highlight = { use_nvim_cmp_as_default = true },
--     },
--   },
--   {
--     "windwp/nvim-autopairs",
--     dev = true,
--     -- dependencies = {
--     --   { "benlubas/nvim-cmp" },
--     -- },
--     event = "VeryLazy",
--     config = function()
--       require("nvim-autopairs").setup({
--         map_bs = false,
--         check_ts = true,
--         fast_wrap = {
--           map = "<A-e>",
--           chars = { "{", "[", "(", '"', "'", "`" },
--           pattern = [=[[%'%"%>%]%)%}%,]]=],
--           end_key = "$",
--           cursor_pos_before = true,
--           keys = "qwertyuiopzxcvbnmasdfghjkl",
--           manual_position = false,
--         },
--       })
--       -- If you want insert `(` after select function or method item
--       -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--       -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
--     end,
--   },
--   {
--     "L3MON4D3/LuaSnip",
--     lazy = true,
--     config = function()
--       local ls = require("luasnip")
--       ls.setup({
--         link_children = true,
--         link_roots = false,
--         keep_roots = false,
--         update_events = { "TextChanged", "TextChangedI" },
--       })
--       local c = ls.choice_node
--       ls.choice_node = function(pos, choices, opts)
--         if opts then
--           opts.restore_cursor = true
--         else
--           opts = { restore_cursor = true }
--         end
--         return c(pos, choices, opts)
--       end
--
--       vim.cmd.runtime({ args = { "lua/snippets/*.lua" }, bang = true }) -- load custom snippets
--
--       vim.keymap.set({ "i", "x" }, "<C-j>", function()
--         if ls.expand_or_jumpable() then
--           ls.expand_or_jump()
--         end
--       end, { silent = true, desc = "expand snippet or jump to the next snippet node" })
--
--       vim.keymap.set({ "i", "x" }, "<C-k>", function()
--         if ls.jumpable(-1) then
--           ls.jump(-1)
--         end
--       end, { silent = true, desc = "previous spot in the snippet" })
--
--       vim.keymap.set({ "i", "x" }, "<C-l>", function()
--         if ls.choice_active() then
--           ls.change_choice(1)
--         end
--       end, { silent = true, desc = "next snippet choice" })
--
--       vim.keymap.set({ "i", "x" }, "<C-h>", function()
--         if ls.choice_active() then
--           ls.change_choice(-1)
--         end
--       end, { silent = true, desc = "previous snippet choice" })
--     end,
--   },
-- }

-- return {
--   { 'echasnovski/mini.completion', version = '*', config = true },
--   { "hrsh7th/cmp-path" }, -- will auto register itself
--   {
--     dir = "~/github/cmp2lsp",
--     event = "VeryLazy",
--     config = vim.schedule_wrap(function()
--       require('cmp2lsp').setup({})
--     end)
--   }
-- }

-- Care.nvim config (care is not ready yet, it's a little laggy, and visually buggy)
-- local labels = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- return {
--   {
--     "max397574/care.nvim",
--     -- enabled = false,
--     dev = true,
--     dependencies = {
--       "max397574/care-lsp",
--       -- "max397574/care-cmp",
--       "hrsh7th/cmp-path",
--       "hrsh7th/cmp-buffer",
--       "L3MON4D3/LuaSnip",
--     },
--     config = function()
--       local care = require("care")
--       -- Set up mappings here
--       vim.keymap.set("i", "<c-n>", function()
--         care.api.complete()
--       end)
--
--       vim.keymap.set("i", "<c-y>", "<Plug>(CareConfirm)")
--       vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
--       vim.keymap.set("i", "<c-n>", function()
--         if not care.api.is_reversed() then
--           care.api.select_next(1)
--         else
--           care.api.select_prev(1)
--         end
--       end)
--       vim.keymap.set("i", "<c-p>", function()
--         if care.api.is_reversed() then
--           care.api.select_next(1)
--         else
--           care.api.select_prev(1)
--         end
--       end)
--
--       vim.keymap.set("i", "<c-u>", function()
--         if care.api.doc_is_open() then
--           care.api.scroll_docs(4)
--         else
--           vim.api.nvim_feedkeys(vim.keycode("<c-u>"), "n", false)
--         end
--       end)
--
--       vim.keymap.set("i", "<c-d>", function()
--         if care.api.doc_is_open() then
--           care.api.scroll_docs(-4)
--         else
--           vim.api.nvim_feedkeys(vim.keycode("<c-d>"), "n", false)
--         end
--       end)
--
--       -- Keymappings
--       for i, label in ipairs(labels) do
--         vim.keymap.set("i", "<m-" .. label .. ">", function()
--           care.api.select_visible(i)
--           care.api.confirm()
--         end)
--       end
--
--       ---@diagnostic disable-next-line: redundant-parameter
--       care.setup({
--         ui = {
--           menu = {
--             border = "none",
--             max_width = 25,
--             format_entry = function(entry, data)
--               local deprecated = entry.completion_item.deprecated or
--               vim.tbl_contains(entry.completion_item.tags or {}, 1)
--               local completion_item = entry.completion_item
--               local type_icons = require("care.config").defaults.ui.type_icons
--               -- TODO: remove since now can only be number, or also allow custom string kinds?
--               local entry_kind = type(completion_item.kind) == "string" and completion_item.kind or
--               require("care.utils.lsp").get_kind_name(completion_item.kind)
--               return {
--                 { {
--                   " " .. require("care.presets.utils").LabelEntries(labels)(entry, data) .. " ",
--                   "Comment",
--                 } },
--                 { { completion_item.label:sub(1, 26), deprecated and "@lsp.mod.deprecated" or "@care.entry" } },
--                 {
--                   {
--                     " " .. (type_icons[entry_kind] or type_icons.Text),
--                     ("@care.type.%s"):format(entry_kind),
--                   },
--                 },
--               }
--             end,
--           },
--           docs_view = {
--             max_height = 10,
--             max_width = 80,
--             border = "none",
--           },
--           ghost_text = {
--             enabled = false,
--           },
--         },
--         snippet_expansion = require("luasnip").lsp_expand,
--         selection_behavior = "select",
--         sorting_direction = "away-from-cursor",
--         confirm_behavior = "insert",
--         sources = {
--           "cmp_buffer",
--
--         },
--         preselect = false,
--         -- debug = true,
--       })
--     end,
--   },
--   {
--     "L3MON4D3/LuaSnip",
--     lazy = true,
--     config = function()
--       local ls = require("luasnip")
--       ls.setup({
--         link_children = true,
--         link_roots = false,
--         keep_roots = false,
--         update_events = { "TextChanged", "TextChangedI" },
--       })
--       local c = ls.choice_node
--       ls.choice_node = function(pos, choices, opts)
--         P(opts)
--         if opts then
--           opts.restore_cursor = true
--         else
--           opts = { restore_cursor = true }
--         end
--         return c(pos, choices, opts)
--       end
--
--       vim.cmd.runtime({ args = { "lua/snippets/*.lua" }, bang = true }) -- load custom snippets
--
--       vim.keymap.set({ "i", "x" }, "<C-j>", function()
--         if ls.expand_or_jumpable() then
--           ls.expand_or_jump()
--         end
--       end, { silent = true, desc = "expand snippet or jump to the next snippet node" })
--
--       vim.keymap.set({ "i", "x" }, "<C-k>", function()
--         if ls.jumpable(-1) then
--           ls.jump(-1)
--         end
--       end, { silent = true, desc = "previous spot in the snippet" })
--
--       vim.keymap.set({ "i", "x" }, "<C-l>", function()
--         if ls.choice_active() then
--           ls.change_choice(1)
--         end
--       end, { silent = true, desc = "next snippet choice" })
--
--       vim.keymap.set({ "i", "x" }, "<C-h>", function()
--         if ls.choice_active() then
--           ls.change_choice(-1)
--         end
--       end, { silent = true, desc = "previous snippet choice" })
--     end,
--   },
--   {
--     "windwp/nvim-autopairs",
--     dev = true,
--     -- dependencies = {
--     --   { "benlubas/nvim-cmp" },
--     -- },
--     event = "VeryLazy",
--     config = function()
--       require("nvim-autopairs").setup({
--         map_bs = false,
--         check_ts = true,
--         fast_wrap = {
--           map = "<A-e>",
--           chars = { "{", "[", "(", '"', "'", "`" },
--           pattern = [=[[%'%"%>%]%)%}%,]]=],
--           end_key = "$",
--           cursor_pos_before = true,
--           keys = "qwertyuiopzxcvbnmasdfghjkl",
--           manual_position = false,
--         },
--       })
--       -- If you want insert `(` after select function or method item
--       -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--       -- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
--     end,
--   },
-- }

local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 25

return {
  {
    "benlubas/nvim-cmp",
    branch = "up_to_date",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "L3MON4D3/LuaSnip" },
    },
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "CmpItemAbbr", {})
      local cmp = require("cmp")

      local keys = {
        ["<C-n>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-y>"] = cmp.mapping.confirm({ select = true }),
      }

      -- key mappings for Alt+number to select, have to press enter after to confirm though
      for i = 0, 9, 1 do
        local key = table.concat({ "<M-", i, ">" })
        keys[key] = function(fallback)
          if cmp.visible() and #cmp.get_entries() > i then
            cmp.select_nth(i + 1)
            cmp.confirm()
            return
          end

          return fallback()
        end
      end

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = {
            winhighlight = winhighlight,
            col_offset = -2,
          },
          documentation = {
            winhighlight = winhighlight,
          },
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        mapping = keys,
        formatting = {
          number_options = {
            start_index = 0,
            end_index = 9,
          },
          fields = { "num", "abbr", "kind" },
          format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
              vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            end
            return vim_item
          end,
        },
        -- Installed sources
        sources = {
          { name = "git" },
          { name = "neorg" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local ls = require("luasnip")
      ls.setup({
        link_children = true,
        link_roots = false,
        keep_roots = false,
        update_events = { "TextChanged", "TextChangedI" },
        enable_autosnippets = true,
      })
      local c = ls.choice_node
      ls.choice_node = function(pos, choices, opts)
        if opts then
          opts.restore_cursor = true
        else
          opts = { restore_cursor = true }
        end
        return c(pos, choices, opts)
      end

      vim.cmd.runtime({ args = { "lua/snippets/*.lua" }, bang = true }) -- load custom snippets

      vim.keymap.set({ "i", "x" }, "<C-j>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "expand snippet or jump to the next snippet node" })

      vim.keymap.set({ "i", "x" }, "<C-k>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "previous spot in the snippet" })

      vim.keymap.set({ "i", "x" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "next snippet choice" })

      vim.keymap.set({ "i", "x" }, "<C-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { silent = true, desc = "previous snippet choice" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    -- dev = true,
    dependencies = {
      { "benlubas/nvim-cmp" },
    },
    event = "VeryLazy",
    config = function()
      require("nvim-autopairs").setup({
        map_bs = false,
        check_ts = true,
        fast_wrap = {
          map = "<A-e>",
          chars = { "{", "[", "(", '"', "'", "`" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          cursor_pos_before = true,
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          manual_position = false,
        },
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
