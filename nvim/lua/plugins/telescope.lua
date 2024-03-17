-- NOTE: I have a lot of telescope mappings setup as "Hydras" see
-- nvim/lua/benlubas/hydra/telescope.lua

-- I use layouts defined at nvim/lua/benlubas/telescope/layouts

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          create_layout = require("benlubas.telescope.layouts.default"),
          path_display = { shorten = { len = 3, exclude = { 1, 2, -1, -2 } } },
          dynamic_preview_title = true,
          sorting_strategy = "ascending",
          cache_picker = {
            num_pickers = 15,    -- default 1
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
            },
          },
        },
        pickers = {
          live_grep = {
            mappings = {
              i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
            },
            prompt_prefix = "rg > ",
            prompt_title = "",
          },
          current_buffer_fuzzy_find = {
            mappings = {
              i = { ["<c-f>"] = require("telescope.actions").to_fuzzy_refine },
            },
            prompt_prefix = "fzf > ",
            prompt_title = "",
          },
          find_files = {
            prompt_prefix = "./",
            prompt_title = "",
          },
          git_status = {
            prompt_prefix = "./",
            prompt_title = "",
            on_complete = { },
          },
        },
      })

      local theme = require("benlubas.color")
      local tel_theme = theme.telescope
      local main = tel_theme.main
      local prompt = tel_theme.prompt

      local highlights = {
        -- Sets the highlight for selected items within the picker.
        TelescopeSelection = { link = "Visual" },
        TelescopeSelectionCaret = { link = "TelescopeSelection" },
        TelescopeMultiSelection = { link = "Type" },
        TelescopeMultiIcon = { link = "Identifier" },

        -- "Normal" in the floating windows created by telescope.
        TelescopeNormal = { bg = main },
        -- TelescopePreviewNormal = { link = "TelescopeNormal" },
        TelescopePromptNormal = { bg = prompt },
        -- TelescopeResultsNormal = { link = "TelescopeNormal" },

        -- Border highlight groups.
        --   Use TelescopeBorder to override the default.
        --   Otherwise set them specifically
        TelescopeBorder = { fg = main, bg = theme.background },
        TelescopePromptBorder = { fg = prompt, bg = main },
        -- TelescopeResultsBorder = { link = "TelescopeBorder" },
        -- TelescopePreviewBorder = { link = "TelescopeBorder" },

        -- Title highlight groups.
        --   Use TelescopeTitle to override the default.
        --   Otherwise set them specifically
        TelescopeTitle = tel_theme.title,
        TelescopePromptTitle = { link = "TelescopeTitle" },
        TelescopeResultsTitle = { link = "TelescopeTitle" },
        TelescopePreviewTitle = { link = "TelescopeTitle" },

        TelescopePromptCounter = { link = "NonText" },

        -- Used for highlighting characters that you match.
        TelescopeMatching = { link = "Special" },

        -- Used for the prompt prefix
        TelescopePromptPrefix = { link = tel_theme.promptPrefix },

        -- Used for highlighting the matched line inside Previewer. Works only for (vim_buffer_ previewer)
        TelescopePreviewLine = { link = "Visual" },
        TelescopePreviewMatch = { link = "Search" },

        TelescopePreviewPipe = { link = tel_theme.pipe },
        TelescopePreviewCharDev = { link = tel_theme.charDev },
        TelescopePreviewDirectory = { link = "Directory" },
        TelescopePreviewBlock = { link = tel_theme.block },
        TelescopePreviewLink = { link = "Special" },
        TelescopePreviewSocket = { link = "Statement" },
        TelescopePreviewRead = { link = tel_theme.read },
        TelescopePreviewWrite = { link = "Statement" },
        TelescopePreviewExecute = { link = "String" },
        TelescopePreviewHyphen = { link = "NonText" },
        TelescopePreviewSticky = { link = "Keyword" },
        TelescopePreviewSize = { link = "String" },
        TelescopePreviewUser = { link = tel_theme.user },
        TelescopePreviewGroup = { link = tel_theme.group },
        TelescopePreviewDate = { link = "Directory" },
        TelescopePreviewMessage = { link = "TelescopePreviewNormal" },
        TelescopePreviewMessageFillchar = { link = "TelescopePreviewMessage" },

        -- Used for Picker specific Results highlighting
        TelescopeResultsClass = { link = "Function" },
        TelescopeResultsConstant = { link = tel_theme.constant },
        TelescopeResultsField = { link = "Function" },
        TelescopeResultsFunction = { link = "Function" },
        TelescopeResultsMethod = { link = "Method" },
        TelescopeResultsOperator = { link = "Operator" },
        TelescopeResultsStruct = { link = "Struct" },
        TelescopeResultsVariable = { link = "SpecialChar" },

        TelescopeResultsLineNr = { link = "LineNr" },
        TelescopeResultsIdentifier = { link = "Identifier" },
        TelescopeResultsNumber = { link = tel_theme.number },
        TelescopeResultsComment = { link = "Comment" },
        TelescopeResultsSpecialComment = { link = "SpecialComment" },

        -- Used for git status Results highlighting
        TelescopeResultsDiffChange = { link = "DiffChange" },
        TelescopeResultsDiffAdd = { link = "DiffAdd" },
        TelescopeResultsDiffDelete = { link = "DiffDelete" },
        TelescopeResultsDiffUntracked = { link = "NonText" },
      }

      for k, v in pairs(highlights) do
        vim.api.nvim_set_hl(0, k, v)
      end

      local ivy = require("benlubas.telescope.layouts.ivy")
      local spelling = require("benlubas.telescope.layouts.spelling")

      vim.keymap.set("n", "<leader>ss", function()
        require("telescope.builtin").spell_suggest({ create_layout = spelling })
      end, { desc = "spell suggest" })
      vim.keymap.set("n", "<leader><leader>s", ":Telescope symbols<CR>", { desc = "open symbol picker" })
      vim.keymap.set("n", "<leader>mx", function()
        require("benlubas.telescope.tmux").tmux_sessionizer_picker({ create_layout = ivy })
      end, { desc = "tmux-sessionizer but telescope" })

      vim.keymap.set("n", "<leader>tx", function()
        require("benlubas.telescope.tmux").tmux_sessions_picker({ create_layout = ivy })
      end, { desc = "Pick between all existing tmux sessions" })
      vim.keymap.set("n", "<leader>*", function()
        require("telescope.builtin").grep_string({
          search = vim.fn.expand("<cword>"),
          create_layout = require("benlubas.telescope.layouts.default"),
          prompt_prefix = '"' .. vim.fn.expand("<cword>") .. '" > ',
        })
      end, { desc = "grep for word under cursor" })
      vim.keymap.set("v", "<leader>*", function()
        require("telescope.builtin").grep_string({ search = vim.getVisualSelection() })
      end, { desc = "grep for highlighted text" })

      require("benlubas.hydra.telescope")
    end,
  },
}
