return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<c-s>"] = require("benlubas.telescope-harpoon-mark").mark_file,
            },
            n = {
              ["<c-s>"] = require("benlubas.telescope-harpoon-mark").mark_file,
            }
          },
        },
      })
      vim.keymap.set("n", "<leader>fj", require('telescope.builtin').current_buffer_fuzzy_find, {desc = "current buffer fuzzy find" })
      vim.keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<CR>", {desc = "Find a word in a file in the directory" })
      vim.keymap.set("n", "<leader>fh", function() require('telescope.builtin').find_files({ hidden = true }) end, { desc = "include hidden files in directory search" })
      vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<CR>", {desc = "search help tags" })
      vim.keymap.set("v", "<leader>h", function()
        require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end, { desc = "help with visual selction"})
      vim.keymap.set("n", "<leader>wh",
      function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end, {desc = "help with word under cursor" })
      vim.keymap.set("n", "<leader>Wh", function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cWORD>") }) end, { desc = "help with WORD under cursor" })
      vim.keymap.set("n", "<leader>fd", function() require("benlubas.telescope-project-files").project_files() end, { desc = "search project files" })
      vim.keymap.set("n", "<leader>ss", function() require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor()) end, { desc = "spell suggest" })
      vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").git_status(require("telescope.themes").get_dropdown()) end, { desc = "search modified git files" })
      vim.keymap.set("n", "<leader><leader>s", ":Telescope symbols<CR>", { desc = "open symbol picker" })
      vim.keymap.set("n", "<leader>fl", function()
        local dir = vim.env.HOME .. "/github/.dotfiles"
        require('telescope.builtin').find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
        })
      end, { desc = "search dot files" })
      vim.keymap.set("n", "<leader>fm",
        function() require("benlubas.telescope-harpoon-mark").harpoon_branch_marks_picker() end,
        { desc = "marks from other branches, select to add marks" })
    end,
  },
}
