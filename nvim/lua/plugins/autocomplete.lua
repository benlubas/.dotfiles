-- File with all things related to auto complete (excluding the LSP server stuff itself)

local winhighlight = {
	winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}

local ELLIPSIS_CHAR = "..."
local MAX_LABEL_WIDTH = 20

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			{ "ray-x/lsp_signature.nvim" },
		},
		config = function() 
      require("cmp").setup({
        window = {
          completion = require("cmp").config.window.bordered(winhighlight),
          documentation = require("cmp").config.window.bordered(winhighlight),
        },
        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },
        mapping = {
          ["<C-n>"] = require("cmp").mapping.select_next_item(),
          ["<C-p>"] = require("cmp").mapping.select_prev_item(),
          ["<C-s>d"] = require("cmp").mapping.scroll_docs(4),
          ["<C-s>u"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-c>"] = require("cmp").mapping.close(),
          ["<CR>"] = require("cmp").mapping.confirm({
            behavior = require("cmp").ConfirmBehavior.Insert,
            select = true,
          }),
        },
        formatting = {
          format = function(_, vim_item)
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
			{ "hrsh7th/nvim-cmp" },
		},
		config = function()
			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
