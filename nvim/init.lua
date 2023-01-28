local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("plugin", {
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "moonfly" },
  },
  custom_keys = {
    -- disable default keybinds
    ["<localleader>t"] = false,
    ["<localleader>l"] = false,
    -- open lazygit log
    ["<leader><leader>l"] = function(plugin)
      require("lazy.util").float_term({ "lazygit", "log" }, {
        cwd = plugin.dir,
      })
    end,
  },
})

require("benlubas")
