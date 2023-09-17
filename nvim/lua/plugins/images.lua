return {
  {
    "3rd/image.nvim",
    -- enabled = false, -- still can't get this to work on mac
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          sizing_strategy = "auto",
          download_remote_images = true,
          clear_in_insert_mode = true,
          only_render_image_at_cursor = false,
        },
        neorg = {
          enabled = true,
          download_remote_images = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 50,
      max_height_window_percentage = 20,
      kitty_method = "normal",
      kitty_tmux_write_delay = 10,          -- makes rendering more reliable with Kitty+Tmux
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}