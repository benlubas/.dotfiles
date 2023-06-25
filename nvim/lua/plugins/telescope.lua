-- NOTE: I have a lot of telescope mappings setup as "Hydras" see nvim/lua/plugins/hydra.lua

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
          layout_strategy = "center",
          path_display = { shorten = { len = 3, exclude = { 1, 2, -1, -2 }}},
          dynamic_preview_title = true,
          winblend = 13,
          sorting_strategy = "ascending",
          cache_picker = {
            num_pickers = 15, -- default 1
            limit_entries = 500, -- default 500
          },
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
            mappings = {
              i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>ss", function() require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor()) end, { desc = "spell suggest" })
      vim.keymap.set("n", "<leader><leader>s", ":Telescope symbols<CR>", { desc = "open symbol picker" })
      vim.keymap.set("n", "<leader>mx",
        function() require("benlubas.telescope.tmux").tmux_sessions_picker({ "~/github", "~/work", "~/notes" }) end,
        { desc = "tmux-sessionizer but telescope" })
    end,
  },
}
