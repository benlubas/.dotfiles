return {
  { "tpope/vim-surround" }, -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  { "tpope/vim-repeat" },   -- allows some plugin actions to be repeated with .
  {
    "Pocco81/auto-save.nvim",
    opts = {
      condition = function(buf)
        local disabled_ft = { 'oil' }

        return vim.api.nvim_buf_get_option(buf, "modifiable") and
          not vim.tbl_contains(disabled_ft, vim.api.nvim_buf_get_option(buf, "filetype"))

      end,
    },
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "kj" },   -- why not both
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", function() require("oil").open() end, desc = "Open parent directory" },
    },
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      },
      buf_options = {
        filetype = "oil",
      },
      win_options = {
        signcolumn = "yes",
        cursorcolumn = true,
        foldcolumn = "1",
        spell = true,
      },
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "none",
        win_options = {
          winblend = 14,
        },
      },
    },
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      {
        "<leader>ds",
        ":lua require('mini.trailspace').trim()<CR>",
        desc = "trim trailing whitespace",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "glg",    -- Line-comment toggle keymap
        block = "gaa",   -- Block-comment toggle keymap
      },
      opleader = {
        line = "gl",
        block = "ga",
      },
      extra = {
        above = "glO",   -- Add comment on the line above
        below = "glo",   -- Add comment on the line below
        eol = "glA",     -- Add comment at the end of line
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "<leader>fo", require("ufo").openAllFolds, { desc = "open all folds" })
      vim.keymap.set("n", "<leader>fc", require("ufo").closeAllFolds, { desc = "close all folds" })
      vim.keymap.set("n", "<leader>i", "za", { desc = "toggle fold" })

      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" ↙️ %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
    end,
  },
}
