local actions = require("telescope.actions")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "nvim-telescope/telescope-fzf-native.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    },
    keys = {
      -- find files in working dir
      { "<leader>fd", function() require("benlubas.telescope-project-files").project_files() end },
      { "<leader>fl", function()
        local dir = vim.env.HOME .. "/github/.dotfiles"
        require('telescope.builtin').find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
        })
      end,
        desc = "search dot files"
      },
      { "<leader>fj", function() require('telescope.builtin').current_buffer_fuzzy_find() end,
        desc = "current buffer fuzzy find" },
      { "<leader>fa", "<cmd>Telescope live_grep<CR>", desc = "Find a word in a file in the directory" },
      { "<leader>fh", function() require('telescope.builtin').find_files({ hidden = true }) end,
        desc = "include hidden files in directory search" },
      { "<leader>h", "<cmd>Telescope help_tags<CR>", desc = "search help tags" },
      { "<leader>h", function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end,
        desc = "help with visual selction", mode = "v" },
      { "<leader>wh", function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end,
        desc = "help with word under cursor" },
      { "<leader>Wh", function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cWORD>") }) end,
        desc = "help with WORD under cursor" },
      { "<leader>c", "<cmd>Telescope neoclip<CR>", desc = "clipboard" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "todo's" },
    },
  },
  { "AckslD/nvim-neoclip.lua", config = true },
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope.builtin").symbols({ sources = { "emoji", "nerd", "juila" } })
    end,
    keys = {
      { "<leader>fs", "<cmd>telescope symbols<cr>", desc = "open symbol picker" },
    },
  },
}
