return {
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "benlubas/nvim-cmp",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local quarto = require("quarto")
    quarto.setup({
      keymap = {
        hover = "H",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
      },
    })

    vim.keymap.set("n", "<localleader>p", quarto.quartoPreview, { silent = true, noremap = true })
    -- for more keybinds that I would use in a quarto document, see the configuration for magma.nvim
    -- located in plugins/repl.lua
  end,
}
