return {
	"nvim-neotest/neotest",
  keys = {
    { "<leader>tr", function() require('neotest').run.run() end, desc = "Run the nearest test" },
    { "<leader>tR", function() require('neotest').run.run(vim.fn.expand("%")) end, desc = "Run the current file" },
    { "<leader>ts", function() require('neotest').run.stop() end, desc = "stop the nearest test" },
    { "<leader>ta", function() require('neotest').run.attach() end, desc = "attach to the nearest test" },
    { "<leader>th", function() require('neotest').output.open({ enter = true }) end, desc = "open output window" },
    { "<leader>td", function() require('neotest').run.run({ strategy = "dap" }) end, desc = "run the test in debug mode." },
  },
  dependencies = {
    { "haydenmeade/neotest-jest" },
    { "olimorris/neotest-rspec" },
  },
	config = function()
    require("neotest").setup({
      adapters = {
        -- these are the defaults
        require("neotest-jest")({
          jestCommand = "yarn jest",
          env = { CI = true },
          cwd = function(_path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-rspec"),
      },
      quickfix = {
        enabled = false,
      },
      discovery = {
        enabled = false,
      },
      status = {
        enabled = true,
        signs = false,
        virtual_text = true,
      },
      log_level = 0,
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "祥",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = " ",
        unknown = "",
      },
    })
  end,
}

