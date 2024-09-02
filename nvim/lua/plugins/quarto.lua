return {
  {
    "GCBallesteros/jupytext.nvim",
    -- ft = { "ipynb" },
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  { "jmbuhr/otter.nvim", ft = { "markdown", "quarto", "norg" } },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "nvim-lspconfig",
      "hydra.nvim",
      "otter.nvim",
    },
    ft = { "quarto", "markdown", "norg" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python", "rust", "lua" },
          chunks = "all", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
          ft_runners = {
            bash = "slime",
          },
          default_method = "molten",
        },
      })

      vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview,
        { desc = "Preview the Quarto document", silent = true, noremap = true })
      -- to create a cell in insert mode, I have the ` snippet
      vim.keymap.set("n", "<localleader>cc", "i`<c-j>", { desc = "Create a new code cell", silent = true })
      vim.keymap.set("n", "<localleader>cs", "i```\r\r```{}<left>",
        { desc = "Split code cell", silent = true, noremap = true })

      -- for more keybinds that I would use in a quarto document, see the configuration for molten
      require("benlubas.hydra.notebook")
    end,
  },
}
