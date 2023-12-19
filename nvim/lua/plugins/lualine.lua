local hydra = function()
  local hint = require("hydra.statusline").get_hint() 
  if hint == nil then
    return ""
  end
  return hint
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = not MarkdownMode(),
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { { "mode", separator = { right = "" } } },
          lualine_b = {
            { "branch", separator = { left = "", right = "" } },
            -- MoonflyCrimsonLine xxx guifg=#ff5189 guibg=#303030
            -- MoonflyEmeraldLine xxx guifg=#36c692 guibg=#303030
            -- MoonflyGrey246Line xxx guifg=#949494 guibg=#1c1c1c
            -- MoonflyYellowLine xxx guifg=#e3c78a guibg=#1c1c1c
            -- MoonflyBlueLineActive xxx guifg=#80a0ff guibg=#444444
            -- MoonflyRedLineActive xxx guifg=#ff5454 guibg=#444444
            -- MoonflyWhiteLineActive xxx guifg=#e4e4e4 guibg=#444444
            -- MoonflyYellowLineActive xxx guifg=#e3c78a guibg=#444444
            {
              "diff",
              diff_color = {
                added = "MoonflyEmerald",
                modified = "MoonflySky",
                removed = "MoonflyRed",
              },
              separator = { left = "", right = "" },
            },
            {
              "diagnostics",
              separator = { left = "", right = "" },
            },
          },
          lualine_c = {
            { "filename", path = 1 },
            require("benlubas.search_count").get_search_count,
            hydra,
          },
          lualine_x = {
            "encoding",
            "fileformat",
            -- require('molten.status').initialized,
            require("molten.status").kernels,
            -- require('molten.status').all_kernels,
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
