require("neotest").setup({
  adapters = {
    -- these are the defaults
    require("neotest-jest")({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(_) -- _ is the path
        return vim.fn.getcwd()
      end,
    }),
    require("neotest-rspec"),
  },
  status = {
    enabled = true,
    signs = false,
    virtual_text = true,
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "❌",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "",
    running = "祥",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = " ",
    unknown = "",
  },
  summary = {
    animated = true,
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = "a",
      clear_marked = "M",
      clear_target = "T",
      debug = "d",
      debug_marked = "D",
      expand = { "<CR>", "<2-LeftMouse>" },
      expand_all = "e",
      jumpto = "i",
      mark = "m",
      next_failed = "J",
      output = "o",
      prev_failed = "K",
      run = "r",
      run_marked = "R",
      short = "O",
      stop = "u",
      target = "t",
    },
    open = "botright vsplit | vertical resize 50",
  },
})
