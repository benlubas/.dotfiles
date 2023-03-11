return {
  "benlubas/harpoon", -- fork that caches the git branch key
  dev = true,
  opts = {
    menu = {
      width = (function()
        local width = vim.api.nvim_win_get_width(0) - 4;
        return math.floor(width - width * 0.55);
      end)(),
    },
    mark_branch = true,
  },
  keys = {
    { "<C-s>", function() require("harpoon.mark").add_file() end, desc = "add current file to harpoon menu" },
    { "<C-e>", function() require("harpoon.ui").toggle_quick_menu(vim.api.nvim_buf_get_name(0)) end, desc = "open harpoon menu" },

    { "<C-h>", function() require("harpoon.ui").nav_file(1) end },
    { "<C-j>", function() require("harpoon.ui").nav_file(2) end },
    { "<C-k>", function() require("harpoon.ui").nav_file(3) end },
    { "<C-l>", function() require("harpoon.ui").nav_file(4) end },

    { "<C-h>", function() require("harpoon.ui").nav_file(1) end, mode = "i" },
    { "<C-j>", function() require("harpoon.ui").nav_file(2) end, mode = "i" },
    { "<C-k>", function() require("harpoon.ui").nav_file(3) end, mode = "i" },
    { "<C-l>", function() require("harpoon.ui").nav_file(4) end, mode = "i" },
  }
}
