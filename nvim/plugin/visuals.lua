-- All of the visual changes that I'm running. This includes, moonfly theme, neoscroll,
-- which-key, devicons, indent_blankline, and lualine

return {
	{
		"bluz71/vim-moonfly-colors",
		lazy = false,
		priority = 1000,
		config = function()
			-- vert line at 100 chars
			vim.opt.colorcolumn = { 100 }

			vim.g.moonflyTransparent = true
			vim.g.moonflyCursorColor = true
			vim.g.moonflyNormalFloat = true
			vim.g.moonflyItalics = false

			-- TODO: move this to dap setup
			-- highlight groups for nvim dap icons
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF3939" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#80EFBE" })

			-- also, amogus symbol b/c it's funny
			vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			vim.cmd("syntax enable")
			vim.cmd([[colorscheme moonfly]])

			vim.cmd([[highlight CursorLine ctermbg=238 guibg=#111111]]) -- this interferes with fold highlighting
			vim.cmd([[highlight Folded ctermfg=63 guifg=#2E5EDB ctermbg=236 guibg=#111111]])
		end,
	},
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		opts = {
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			hide_cursor = false,
			stop_eof = false,
			post_hook = function() -- function to flash the line that we land on
				vim.opt.cul = true
				vim.defer_fn(function()
					vim.opt.cul = false
				end, 350)
			end,
		},
	},
	"folke/which-key",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 }, require("benlubas.search_count").get_search_count },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			space_char_blankline = " ",
			show_current_context = true,
		},
	},
	{
		"folke/todo-comments.nvim",
		highlight = {
			before = "fg",
			keyword = "bg",
			after = "",
		},
	},
}
