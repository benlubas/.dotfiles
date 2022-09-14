require('neotest').setup({
  adapters = {
    -- these are the defaults
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(_path)
        return vim.fn.getcwd()
      end,
    }),
  },
  status = {
    enabled = true,
    signs = false,
    virtual_text = true
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = '❌',
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "",
    running = "祥",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = " ",
    unknown = ""
  },
})
