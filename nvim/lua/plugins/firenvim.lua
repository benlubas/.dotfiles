return {
  "glacambre/firenvim",

  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  lazy = not vim.g.started_by_firenvim,
  module = false,
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  init = function()
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = {
        [".*"] = {
          cmdline = "firenvim",
          content = "text",
          priority = 0,
          selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
          takeover = "empty",
        },
        [ [[.*notion\.so.*]] ] = {
          priority = 9,
          takeover = "never",
        },
        [ [[.*docs\.google\.com.*]] ] = {
          priority = 9,
          takeover = "never",
        },
        [ [[.*teams\.microsoft\.com.*]] ] = {
          priority = 9,
          takeover = "never",
        },
      },
    }
  end,
  config = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true
    vim.opt.showbreak = ""

    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.numberwidth = 0
    vim.opt.foldcolumn = "0"
    vim.opt.signcolumn = "auto"

    vim.opt.textwidth = 0
    vim.opt.colorcolumn = ""

    vim.opt.scrolloff = 2
    vim.opt.sidescrolloff = 8

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "github.com_*.txt",
      cmd = "set filetype=markdown",
    })
  end,
}
