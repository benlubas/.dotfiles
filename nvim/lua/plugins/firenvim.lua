return {
  "glacambre/firenvim",
  enabled = false,
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
          takeover = "never",
        },
      },
    }
  end,
}
