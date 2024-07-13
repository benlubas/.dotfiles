return {
  {
    "benlubas/harpoon", -- fork that caches the git branch key, and adds some highlights and stuff
    dev = true,
    config = function()
      local theme = require("benlubas.color")
      vim.api.nvim_set_hl(0, "HarpoonBorder", theme.fancy_float.border)
      vim.api.nvim_set_hl(0, "HarpoonWindow", theme.fancy_float.window)
      vim.api.nvim_set_hl(0, "HarpoonTitle", theme.fancy_float.title)
      vim.api.nvim_set_hl(0, "HarpoonCurrent", { fg = theme.harpoon_current })

      require("harpoon").setup({
        menu = {
          width = (function()
            local width = vim.api.nvim_win_get_width(0) - 4
            return math.floor(width - width * 0.55)
          end)(),
          borderchars = Border,
        },
        mark_branch = true,
        excluded_filetypes = { "harpoon", "starter", "oil", "molten_output" },
      })
    end,
    keys = {
      { mode = { "n", "v" }, "<C-s>", function() require("harpoon.mark").add_file() end, desc = "add current file to harpoon menu" },
      { mode = { "n", "v" }, "<C-f>",
        function() require("harpoon.ui").toggle_quick_menu(vim.api.nvim_buf_get_name(0)) end,
        desc = "open harpoon menu",
      },

      { mode = { "n" }, "<C-h>", function() require("harpoon.ui").nav_file(1) end },
      { mode = { "n" }, "<C-j>", function() require("harpoon.ui").nav_file(2) end },
      { mode = { "n" }, "<C-k>", function() require("harpoon.ui").nav_file(3) end },
      { mode = { "n" }, "<C-l>", function() require("harpoon.ui").nav_file(4) end },
    },
  },
}
