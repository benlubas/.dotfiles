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


-- TODO: this isn't picking up the magick rock for some reason
-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- ensure that P() and R() are available in plugins
require("benlubas.globals")
require("lazy").setup("plugins", {
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "moonfly" },
  },
  change_detection = {
    enabled = false,
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
  dev = {
    path = "~/github",
  },
})

require("benlubas")
