
return {
  "quarto-dev/quarto-nvim",
  dependencies = {
    "jmbuhr/otter.nvim",
    "benlubas/nvim-cmp",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
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

    vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview,
      { desc = "Preview the Quarto document", silent = true, noremap = true })
    -- to create a cell in insert mode, I have the ` snippet
    vim.keymap.set("n", "<localleader>cc", "i```{}\r```<up><right>",
      { desc = "Create a new code cell", silent = true })
    vim.keymap.set("n", "<localleader>cs", "i```\r\r```{}<left>",
      { desc = "Split code cell", silent = true, noremap = true })

    -- for more keybinds that I would use in a quarto document, see the configuration for molten
  end,
}
