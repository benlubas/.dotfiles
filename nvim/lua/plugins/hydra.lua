return {
  "nvimtools/hydra.nvim",
  dependencies = { "MunifTanjim/nougat.nvim" },
  dev = true,
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

    require("hydra").setup({
      hint = {
        type = "window",
        show_name = false,
        position = { "middle" },
        float_opts = {
          border = Border,
        },
      },
      on_enter = function()
        require("nougat").refresh_statusline(true)
      end,
      on_exit = function()
        vim.schedule(function()
          require("nougat").refresh_statusline(true)
        end)
      end,
    })

    require("benlubas.hydra.options")
    require("benlubas.hydra.windows")
  end,
}
