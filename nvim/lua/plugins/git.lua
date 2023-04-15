return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      sign_priority = 100, -- set really high so it always shows on the far left
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
