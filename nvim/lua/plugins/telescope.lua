return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function() 
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>fj", require('telescope.builtin').current_buffer_fuzzy_find, {desc = "current buffer fuzzy find" })
      vim.keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<CR>", {desc = "Find a word in a file in the directory" })
      vim.keymap.set("n", "<leader>fh", function() require('telescope.builtin').find_files({ hidden = true }) end, {desc = "include hidden files in directory search" })
      vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<CR>", {desc = "search help tags" })
      vim.keymap.set("v", "<leader>h", function() 
        require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end, { desc = "help with visual selction"})
      vim.keymap.set("n", "<leader>wh", 
      function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cword>") }) end, {desc = "help with word under cursor" })
      vim.keymap.set("n", "<leader>Wh", function() require('telescope.builtin').help_tags({ default_text = vim.fn.expand("<cWORD>") }) end, {desc = "help with WORD under cursor" })
      vim.keymap.set("n", "<leader>c", "<cmd>Telescope neoclip<CR>", { desc = "clipboard" })
      vim.keymap.set("n", "<leader>fd", function() require("benlubas.telescope-project-files").project_files() end, { desc = "search project files" })     
      vim.keymap.set("n", "<leader>ss", require('telescope.builtin').spell_suggest(require("telescope.themes").get_cursor), {desc = "spell suggest" })
      -- find files in working dir
      vim.keymap.set("n", "<leader>fl", function()
        local dir = vim.env.HOME .. "/github/.dotfiles"
        require('telescope.builtin').find_files({
          find_command = { "rg", "--files", "--iglob", "!.git", "--hidden", dir },
        })
      end,
      {desc = "search dot files"})
    end,
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
