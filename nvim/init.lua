vim.loader.enable()

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

vim.deprecate = function() end

vim.g.mapleader = " "

-- ensure that P() and R() are available in plugins
require("benlubas.globals")

-- this makes is easy to bisect my setup
local plugins = {
  { import = "plugins.autocomplete" },
  { import = "plugins.base" },
  { import = "plugins.dap" },
  { import = "plugins.firenvim" },
  { import = "plugins.git" },
  { import = "plugins.harpoon" },
  { import = "plugins.hydra" },
  { import = "plugins.images" },
  { import = "plugins.leap" },
  { import = "plugins.line" },
  { import = "plugins.lsp" },
  { import = "plugins.neorg" },
  { import = "plugins.neotest" },
  { import = "plugins.noice" }, -- This is still a little too buggy for me
  { import = "plugins.oil" },
  { import = "plugins.quarto" },
  { import = "plugins.repl" },
  { import = "plugins.telescope" },
  { import = "plugins.treesitter" },
  { import = "plugins.typst" },
  { import = "plugins.visuals" },
}

require("lazy").setup(plugins, {
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "moonfly", "carbonfox" },
  },
  performance = {
    reset_packpath = false, -- if we install some plugins with nix this would break them
  },
  change_detection = {
    enabled = false,
  },
  custom_keys = {
    -- disable default keybinds
    ["<localleader>t"] = false,
    ["<localleader>l"] = false,
  },
  dev = {
    path = "~/github",
  },
})

require("benlubas")
