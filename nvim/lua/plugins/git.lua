return {
  {
    "ruifm/gitlinker.nvim",
    enabled = PLUGIN_ENABLE,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      { -- default <leader>gy is a default mapping that includes the line number
        "<leader>gY",
        function()
          require("gitlinker").get_buf_range_url("n", { add_current_line_on_normal_mode = false })
        end,
        mode = { "n", "v" },
        desc = "Copy git link to current file"
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n", { add_current_line_on_normal_mode = true })
        end,
        mode = { "n", "v" },
        desc = "Copy git link to current line"
      }
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    -- enabled = PLUGIN_ENABLE,
    opts = {
      sign_priority = 100, -- set really high so it always shows on the far left
      signcolumn = true,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "none",
        style = "minimal",
        relative = "cursor",
        row = 1,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        map("n", "<leader>gd", gs.preview_hunk, { desc = "preview git hunk" })
        map("n", "<leader>gb", gs.blame_line, { desc = "blame line" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "diff file" })
        map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>")
        map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })

        -- Movement
        map("n", "<leader>gn", function()
          if vim.wo.diff then
            return "gn"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "<leader>gp", function()
          if vim.wo.diff then
            return "gp"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })
      end,
    },
  },
}
