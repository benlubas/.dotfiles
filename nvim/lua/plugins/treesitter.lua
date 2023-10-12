return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = PLUGIN_ENABLE,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      enabled = PLUGIN_ENABLE,
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
    enabled = PLUGIN_ENABLE,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      enabled = PLUGIN_ENABLE,
      "windwp/nvim-ts-autotag",
      enabled = PLUGIN_ENABLE,
      "JoosepAlviste/nvim-ts-context-commentstring",
      enabled = PLUGIN_ENABLE,
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
          -- TODO: broken in nightly
          -- enable = false,
        },
        -- this is amazing.
        textobjects = {
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]b"] = { query = "@block.inner", desc = "next block" },
            },
            goto_previous_start = {
              ["[b"] = { query = "@block.outer", desc = "previous block" },
            }
          },
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
              ["ib"] = { query = "@block.inner", desc = "in block" },
              ["ab"] = { query = "@block.outer", desc = "around block" },
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
          "devicetree", -- ft = dts, for zmk keymaps
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
    enabled = PLUGIN_ENABLE,
    config = function()
      -- by default, no mappings are created.
      require("various-textobjs").setup({
        lookForwardLines = 8, -- default 5
      })

      -- these have to be commands instead of calling the lua functions so that dot repeat works
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
