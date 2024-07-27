return {
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    dev = true,
    config = function()
      -- track all the lines of leaf nodes so we don't have to recompute them on each key press
      local jumpable_lines
      local function set_jumpabe_lines(context)
        jumpable_lines = {}
        local i = 1
        local n, _, _ = context.tree:get_node(i)
        while n do
          if not n:has_children() then
            table.insert(jumpable_lines, i)
          end
          i = i + 1
          n, _, _ = context.tree:get_node(i)
        end
      end

      require("hunk").setup({
        keys = {
          tree = {
            n = {
              ["j"] = function(context)
                -- unfortunately we have to recompute every time because folding ruins these computed values
                set_jumpabe_lines(context)

                local row = vim.api.nvim_win_get_cursor(0)[1]
                if row < jumpable_lines[1] then
                  vim.api.nvim_win_set_cursor(0, { jumpable_lines[1], 0 })
                  return
                end
                for idx = #jumpable_lines, 1, -1 do
                  if jumpable_lines[idx] <= row then
                    if jumpable_lines[idx + 1] then
                      vim.api.nvim_win_set_cursor(0, { jumpable_lines[idx + 1], 0 })
                    end
                    return
                  end
                end
              end,
              ["k"] = function(context)
                set_jumpabe_lines(context)

                local row = vim.api.nvim_win_get_cursor(0)[1]
                if row > jumpable_lines[#jumpable_lines] then
                  vim.api.nvim_win_set_cursor(0, { jumpable_lines[#jumpable_lines], 0 })
                  return
                end

                for idx, node_row in ipairs(jumpable_lines) do
                  if node_row >= row then
                    if jumpable_lines[idx - 1] then
                      vim.api.nvim_win_set_cursor(0, { jumpable_lines[idx - 1], 0 })
                    end
                    return
                  end
                end
              end,
            },
          },
        },
      })
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      {
        "<leader>gY",
        function()
          require("gitlinker").get_buf_range_url("n", { add_current_line_on_normal_mode = false })
        end,
        mode = { "n", "v" },
        desc = "Copy git link to current file",
      },
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n", { add_current_line_on_normal_mode = true })
        end,
        mode = { "n", "v" },
        desc = "Copy git link to current line",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
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
