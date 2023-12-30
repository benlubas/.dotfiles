return {
  -- "nvimtools/hydra.nvim",
  -- dev = true,
  "benlubas/hydra.nvim",
  branch = "readme_overhaul",
  config = function()
    vim.api.nvim_set_hl(0, "HydraRed", { link = "MoonflyRed" })
    vim.api.nvim_set_hl(0, "HydraBlue", { link = "MoonflySky" })
    vim.api.nvim_set_hl(0, "HydraAmaranth", { link = "MoonflyCranberry" })
    vim.api.nvim_set_hl(0, "HydraTeal", { link = "MoonflyTurquoise" })
    vim.api.nvim_set_hl(0, "HydraPink", { link = "MoonflyCrimson" })

    local colors = require("moonfly").palette
    vim.api.nvim_set_hl(0, "HydraHint", { bg = colors.grey234 })
    vim.api.nvim_set_hl(0, "HydraBorder", { fg = colors.grey234 })
    vim.api.nvim_set_hl(0, "HydraTitle", { fg = colors.black, bg = colors.blue })
    vim.api.nvim_set_hl(0, "HydraFooter", { fg = colors.black, bg = colors.red })

    require("plugins.hydra.telescope")
    require("plugins.hydra.options")
    require("plugins.hydra.windows")
  end,
}
