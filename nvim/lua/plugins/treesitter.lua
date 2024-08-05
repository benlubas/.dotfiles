return {
  {
    "nvim-treesitter",
    dir = vim.g.nix_packdir .. "/nvim-treesitter",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighing = { "typst" },
        },
        indent = {
          enable = true,
          disable = {
            "ruby",
          },
        },
        autotag = {
          enable = false,
        },
        -- this is amazing.
        textobjects = {
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
              ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
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
              ["ia"] = { query = "@parameter.inner", desc = "in parameter" },
              ["aa"] = { query = "@parameter.outer", desc = "around parameter" },
              ["in"] = { query = "@number.inner", desc = "in number" },
              ["ib"] = { query = "@code_cell.inner", desc = "in block" },
              ["ab"] = { query = "@code_cell.outer", desc = "around block" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sal"] = "@parameter.inner",
              ["<leader>sfl"] = "@function.outer",
              ["<leader>sbl"] = "@code_cell.outer",
              ["<leader>snl"] = "@number.outer",
            },
            swap_previous = {
              ["<leader>sah"] = "@parameter.inner",
              ["<leader>sfh"] = "@function.outer",
              ["<leader>sbh"] = "@code_cell.outer",
              ["<leader>snh"] = "@number.outer",
            },
          },
        },
      })
      require("nvim-treesitter").setup()
    end,
  },
  {
    "benlubas/nvim-treesitter-context",
    branch = "collapse_context",
    event = "FileType",
  },
  {
    "echasnovski/mini.ai",
    event = "FileType",
    opts = {
      custom_textobjects = {
        -- these two are handled by TS text objects
        f = false,
        a = false,
        -- These ones have annoying behavior
        ["{"] = false,
        ["}"] = false,
        ["("] = false,
        [")"] = false,
        ["["] = false,
        ["]"] = false,
      },

      mappings = {
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",

        goto_left = "",
        goto_right = "",
      },

      -- Number of lines within which textobject is searched
      n_lines = 0,
    },
    version = "*",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "FileType",
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>sh", ":TSJJoin<CR>", silent = true },
      { "<leader>sl", ":TSJSplit<CR>", silent = true },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "FileType",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        toggler = {
          line = "glg", -- Line-comment toggle keymap
          block = "gaa", -- Block-comment toggle keymap
        },
        opleader = {
          line = "gl",
          block = "ga",
        },
        extra = {
          above = "glO", -- Add comment on the line above
          below = "glo", -- Add comment on the line below
          eol = "glA", -- Add comment at the end of line
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

      -- these have to be commands instead of calling the lua functions so that dot repeat works
      -- correctly
      vim.keymap.set({ "o", "x" }, "is", ":lua require('various-textobjs').subword(true)<CR>", { silent = true, desc = "inner subword" })
      vim.keymap.set({ "o", "x" }, "as", ":lua require('various-textobjs').subword(false)<CR>", { silent = true, desc = "around subword" })
    end,
  },
}
