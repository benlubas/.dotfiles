return {
  {
    "benlubas/harpoon", -- fork that caches the git branch key, and adds some highlights and stuff
    dev = true,
    config = function()
      local colors = require("moonfly").palette
      vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = colors.grey233 })
      vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = colors.grey233 })
      vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = colors.black, bg = colors.blue })
      vim.api.nvim_set_hl(0, "HarpoonCurrent", { fg = colors.orchid })

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

      { mode = { "n", "v" }, "<C-h>", function() require("harpoon.ui").nav_file(1) end },
      { mode = { "n", "v" }, "<C-j>", function() require("harpoon.ui").nav_file(2) end },
      { mode = { "n", "v" }, "<C-k>", function() require("harpoon.ui").nav_file(3) end },
      { mode = { "n", "v" }, "<C-l>", function() require("harpoon.ui").nav_file(4) end },
    },
  },
}
