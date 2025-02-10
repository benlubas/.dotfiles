return {
  "nvimtools/hydra.nvim",
  dependencies = { "MunifTanjim/nougat.nvim" },
  -- dev = true,
  config = function()
    local theme = require('benlubas.color')

    vim.api.nvim_set_hl(0, "HydraRed", theme.hydra.red)
    vim.api.nvim_set_hl(0, "HydraBlue", theme.hydra.blue)
    vim.api.nvim_set_hl(0, "HydraAmaranth", theme.hydra.amaranth)
    vim.api.nvim_set_hl(0, "HydraTeal", theme.hydra.teal)
    vim.api.nvim_set_hl(0, "HydraPink", theme.hydra.pink)

    vim.api.nvim_set_hl(0, "HydraHint", theme.fancy_float.window)
    vim.api.nvim_set_hl(0, "HydraBorder", theme.fancy_float.border)
    vim.api.nvim_set_hl(0, "HydraTitle", theme.fancy_float.title)
    vim.api.nvim_set_hl(0, "HydraFooter", theme.fancy_float.title)

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
