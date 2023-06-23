return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              mirror = true,
            },
          },
          path_display = { shorten = { len = 3, exclude = { 1, 2, -1, -2 }}},
          dynamic_preview_title = true,
          winblend = 13,
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<c-s>"] = require("benlubas.telescope.harpoon").mark_file,
              ["<C-h>"] = require("telescope.actions").cycle_history_prev,
              ["<C-l>"] = require("telescope.actions").cycle_history_next,
            },
            n = {
              ["<c-s>"] = require("benlubas.telescope.harpoon").mark_file,
            }
          },
        },
        pickers = {
          live_grep = {
            cache_picker = {
              num_pickers = 15, -- default 1
              limit_entries = 500, -- default 500
            },
            mappings = {
              i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").resume, { desc = "resume last search" })

      vim.keymap.set("n", "<leader>fj", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "current buffer fuzzy find" })
      vim.keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<CR>", { desc = "Find a word in a file in the directory" })
      vim.keymap.set("n", "<leader>f.", function() require("telescope.builtin").find_files({ hidden = true }) end, { desc = "include hidden files in directory search" })

      vim.keymap.set("n", "<leader>fhf", "<cmd>Telescope help_tags<CR>", { desc = "search help tags" })
      vim.keymap.set("v", "<leader>fh", function() require("telescope.builtin").help_tags({ default_text = vim.fn.expand("<cword>") }) end, { desc = "help with visual selection" })
      vim.keymap.set("n", "<leader>fhw", function() require("telescope.builtin").help_tags({ default_text = vim.fn.expand("<cword>") }) end, { desc = "help with word under cursor" })
      vim.keymap.set("n", "<leader>fhW", function() require("telescope.builtin").help_tags({ default_text = vim.fn.expand("<cWORD>") }) end, { desc = "help with WORD under cursor" })

      vim.keymap.set("n", "<leader>fd", function() require("benlubas.telescope.project-files").project_files() end, { desc = "search project files" })
      vim.keymap.set("n", "<leader>ss", function() require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor()) end, { desc = "spell suggest" })
      vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").git_status(require("telescope.themes").get_dropdown()) end, { desc = "search modified git files" })
      vim.keymap.set("n", "<leader><leader>s", ":Telescope symbols<CR>", { desc = "open symbol picker" })
      vim.keymap.set("n", "<leader>fl", function()
        local dir = vim.env.HOME .. "/github/.dotfiles"
        require("telescope.builtin").find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
        })
      end, { desc = "search dot files" })

    vim.keymap.set("n", "<leader>fn", function()
        local dir = vim.env.HOME .. "/notes"
        require("telescope.builtin").find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
        })
      end, { desc = "search in notes directory" })

      vim.keymap.set("n", "<leader>fm",
        function() require("benlubas.telescope.harpoon").harpoon_branch_marks_picker() end,
        { desc = "marks from other branches, select to add marks" })
      vim.keymap.set("n", "<leader>mx",
        function() require("benlubas.telescope.tmux").tmux_sessions_picker({ "~/github", "~/work", "~/notes" }) end,
        { desc = "tmux-sessionizer but telescope" })
    end,
  },
}
