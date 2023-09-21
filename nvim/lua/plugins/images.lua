return {
  {
    -- "3rd/image.nvim",
    "benlubas/image.nvim",
    dev = true,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          sizing_strategy = "auto",
          download_remote_images = false,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
          filetype = { "markdown", "quarto" },
        },
        neorg = {
          enabled = true,
          download_remote_images = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
        },
      },
      max_width = 100, -- terminal cells
      max_height = 7,
      kitty_method = "normal", -- "normal" or "unicode-placeholders" unicode-placeholders is really weird, and doesn't seem to work
      kitty_tmux_write_delay = 10,          -- makes rendering more reliable with Kitty+Tmux
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
