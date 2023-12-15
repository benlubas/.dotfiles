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
    local never_open = {
      [[.*notion\.so.*]],
      [[.*docs\.google\.com.*]],
      [[.*teams\.microsoft\.com.*]],
      [[.*gradescope\.com.*]],
      [[.*web\.whatsapp\.com.*]],
      [[.*messages\.google\.com.*]],
    }
    local localSettings = {
      [".*"] = {
        cmdline = "firenvim",
        content = "text",
        priority = 0,
        selector = 'textarea:not([readonly]):not([class="handsontableInput"]), div[role="textbox"]',
        takeover = "empty",
      },
    }
    for _, v in ipairs(never_open) do
      localSettings[v] = {
        priority = 9,
        takeover = "never",
      }
    end
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = localSettings,
    }
  end,
}
