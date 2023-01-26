return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        map('n', '<leader>gd', gs.preview_hunk) -- show a small floating diff
        map('n', '<leader>gb', function() gs.blame_line end) -- show the blame, full commit and everything for this line.
        map('n', '<leader>gD', function() gs.diffthis('~') end) -- show a diff for the whole file in a new window
        map({ 'n', 'v' }, '<leader>ga', ':Gitsigns stage_hunk<CR>') -- stage the current hunk
        map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>') -- reset the current hunk
        map('n', '<leader>gu', gs.undo_stage_hunk) -- unstage the current hunk
      end
    },
  },
}
