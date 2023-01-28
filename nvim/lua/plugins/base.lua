return {
  { "tpope/vim-surround" }, -- lets you surround things with ysiw<thing> or edit the surroundings with cs<thing>
  { "tpope/vim-repeat" }, -- allows some plugin actions to be repeated with .
  {
    "Pocco81/auto-save.nvim",
    config = true,
  },
  {
    "kevinhwang91/rnvimr",
    config = function()
      vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders both" }
      vim.g.rnvimr_shadow_winblend = 100 -- no shadow
      vim.g.rnvimr_enable_ex = true
      vim.cmd([[highlight link RnvimrNormal CursorLine]])
    end,
    keys = {
      { "<leader>e", ":RnvimrToggle<CR>", desc = "open ranger" },
    },
  },
}
