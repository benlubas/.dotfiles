-- File with all things related to auto complete (excluding the LSP server stuff itself)

local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"

local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 25

return {
  {
    "benlubas/nvim-cmp",
    dev = true,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "L3MON4D3/LuaSnip" },
    },
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
        ["<C-s>d"] = cmp.mapping.scroll_docs(4),
        ["<C-s>u"] = cmp.mapping.scroll_docs(-4),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
      }

      -- key mappings for Alt+number to select, have to press enter after to confirm though
      for i = 0, 9, 1 do
        local key = table.concat({ "<M-", i, ">" })
        keys[key] = function(fallback)
          if cmp.visible() and #cmp.get_entries() > i then
            return cmp.select_nth(i + 1)
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
          fields = { "num", "abbr", "kind", "menu" },
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
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "nvim_lsp_signature_help" },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "1.*",
    config = function()
      local ls = require("luasnip")
      ls.setup({
        history = false,
        -- this is causing issues for some reason
        -- update_events = { "TextChanged", "TextChangedI" },
      })
      require("snippets") -- loading custom snippets

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "expand snippet or jump to the next snippet node" })

      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "previous spot in the snippet" })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "next snippet choice" })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { silent = true, desc = "previous snippet choice" })
    end,
  },
  {
    "windwp/nvim-autopairs",
    dependencies = {
      { "benlubas/nvim-cmp", dev = true },
    },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
