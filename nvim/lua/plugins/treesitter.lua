return {
	{ "nvim-treesitter/nvim-treesitter-context",
    opts = {
      patterns = {
        ruby = {
          'context',
          'describe',
          'it',
        }
      }
    },
  },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = "TSUpdate",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighing = false,
			},
			indent = {
				enable = true,
			},
			-- this is amazing.
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
			ensure_installed = {
				"c",
				"css",
				"html",
				"java",
				"javascript",
				"jsdoc",
				"lua",
				"markdown",
				"markdown_inline",
				"norg",
				"python",
				"ruby",
				"rust",
				"sql",
				"svelte",
				"tsx",
				"typescript",
				"yaml",
				"vim",
			},
		},
	},
}
