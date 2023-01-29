return {
  { "tpope/vim-surround" }, -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  { "tpope/vim-repeat" }, -- allows some plugin actions to be repeated with .
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
    config = function()
      vim.keymap.set(
        "n",
        "<leader>ds",
        require("mini.trailspace").trim,
        { desc = "trim trailing whitespace" }
      )
    end,
  },
}
