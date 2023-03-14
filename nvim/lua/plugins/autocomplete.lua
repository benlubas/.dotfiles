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
      { "ray-x/lsp_signature.nvim" },
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
          if vim.tbl_count(cmp.get_entries()) <= i then
            return fallback()
          end
          if cmp.visible() then
            if not cmp.get_selected_entry() then
              cmp.select_next_item()
            end

            cmp.select_next_item({ count = i })
          end

          fallback()
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
          number_options = true,
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
    "windwp/nvim-autopairs",
    dependencies = {
      { "benlubas/nvim-cmp", dev = true },
    },
    config = function()
      require("nvim-autopairs").setup({})

      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
