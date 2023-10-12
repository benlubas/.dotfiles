-- TODO: this creates a lag spike and blocks UI for a noticeable amount of time on startup
return {
  "quarto-dev/quarto-nvim",
  enabled = PLUGIN_ENABLE,
  dependencies = {
    "jmbuhr/otter.nvim",
    enabled = PLUGIN_ENABLE,
    "benlubas/nvim-cmp",
    enabled = PLUGIN_ENABLE,
    "neovim/nvim-lspconfig",
    enabled = PLUGIN_ENABLE,
    "nvim-treesitter/nvim-treesitter",
    enabled = PLUGIN_ENABLE,
  },
  ft = { "quarto", "markdown" },
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

    vim.keymap.set("n", "<localleader>p", quarto.quartoPreview,
      { desc = "Preview the Quarto document", silent = true, noremap = true })
    -- to create a cell in insert mode, I have the ` snippet
    vim.keymap.set("n", "<localleader>cc", "i```{}\r```<up><right>",
      { desc = "Create a new code cell", silent = true })
    vim.keymap.set("n", "<localleader>cs", "i```\r\r```{}<left>",
      { desc = "Split code cell", silent = true, noremap = true })

    -- for more keybinds that I would use in a quarto document, see the configuration for magma.nvim
    -- located in plugins/repl.lua
  end,
}
