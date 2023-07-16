return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      patterns = {
        ruby = {
          "block",
          "module",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    lazy = false,
    cmd = "TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighing = false,
        },
        indent = {
          enable = true,
          disable = {
            "ruby",
          },
        },
        autotag = {
          enable = true,
        },
        -- this is amazing.
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "around function" },
              ["if"] = { query = "@function.inner", desc = "in function" },
              ["ac"] = { query = "@class.outer", desc = "around class" },
              ["ic"] = { query = "@class.inner", desc = "in class" },
              ["ik"] = { query = "@assignment.lhs", desc = "in key" },
              ["iv"] = { query = "@assignment.rhs", desc = "in value" },
              ["i/"] = { query = "@regex.inner", desc = "in regex" },
              ["a/"] = { query = "@regex.outer", desc = "around regex" },
              ["iP"] = { query = "@parameter.inner", desc = "in parameter" },
              ["in"] = { query = "@number.inner", desc = "in number" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
        ensure_installed = {
          "c",
          "css",
          "vimdoc",
          "html",
          "java",
          "javascript",
          "jsdoc",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "ruby",
          "rust",
          "sql",
          "svelte",
          "tsx",
          "typescript",
          "yaml",
          "vim",
        },
      })
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      -- by default, no mappings are created.
      require("various-textobjs").setup({
        lookForwardLines = 8, -- default 5
      })

      -- these nave to be commands instead of calling the lua functions so that dot repeat works
      -- correctly
      vim.keymap.set(
        { "o", "x" },
        "is",
        ":lua require('various-textobjs').subword(true)<CR>",
        { silent = true, desc = "inner subword" }
      )
      vim.keymap.set(
        { "o", "x" },
        "as",
        ":lua require('various-textobjs').subword(false)<CR>",
        { silent = true, desc = "around subword" }
      )
    end,
  },
}
