
-- All of the visual changes that I'm running. This includes, moonfly theme, neoscroll, 
-- which-key, devicons, indent_blankline, yank highlight autocommand, and lualine

require("neoscroll").setup({
	mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
	hide_cursor = false,
	stop_eof = false,
	post_hook = function() -- function to flash the line that we land on
		vim.opt.cul = true
		vim.defer_fn(function()
			vim.opt.cul = false
		end, 350)
	end,
})

require("treesitter-context").setup()

require("which-key").setup()
require("nvim-web-devicons").setup()

-- vert line at 100 chars
vim.opt.colorcolumn = { 100 }

vim.g.moonflyTransparent = true

vim.g.moonflyCursorColor = true -- this doesn't work for some reason in wezterm
vim.g.moonflyNormalFloat = true
vim.g.moonflyItalics = false -- this is the most inconsistent thing ever

vim.cmd("syntax enable")
vim.cmd([[colorscheme moonfly]])

vim.cmd([[highlight CursorLine ctermbg=238 guibg=#111111]]) -- this interferes with fold highlighting
vim.cmd([[highlight Folded ctermfg=63 guifg=#2E5EDB ctermbg=236 guibg=#111111]])

-- boarders for the text that pops up for autocomplete and stuff
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
	border = "single",
})

vim.diagnostic.config({ float = { border = "single" } })

-- Indentation
require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	-- show_current_context_start = true,
})

require("todo-comments").setup({
	highlight = {
		before = "fg",
		keyword = "bg",
		after = "",
	},
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

require("lualine").setup({
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
})

-- highlight groups for nvim dap icons
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF3939" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#80EFBE" })

-- also, amogus symbol b/c it's funny
vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
