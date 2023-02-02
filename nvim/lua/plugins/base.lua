return {
  { "tpope/vim-surround" }, -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  { "tpope/vim-repeat" }, -- allows some plugin actions to be repeated with .
  { "benlubas/ramora", dev = true, lazy = false },
  {
    "Pocco81/auto-save.nvim",
    config = true,
  },
  {
    "kevinhwang91/rnvimr",
    keys = {
      { "<leader>e", ":RnvimrToggle<CR>", desc = "open ranger" },
    },
  },
  {
    "echasnovski/mini.trailspace",
    keys = {
      {
        "<leader>ds",
        ":lua require('mini.trailspace').trim()<CR>",
        desc = "trim trailing whitespace",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        -- Line-comment toggle keymap
        line = "glg",
        -- Block-comment toggle keymap (this one doesn't do the whole line, it does
        -- to the end of the line.
        block = "gaa",
      },
      opleader = {
        line = "gl",
        block = "ga",
      },
      extra = {
        -- Add comment on the line above
        above = "glO",
        -- Add comment on the line below
        below = "glo",
        -- Add comment at the end of line
        eol = "glA",
      },
    },
  },
}
