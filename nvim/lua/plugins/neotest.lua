---@diagnostic disable: missing-fields
return {
  "nvim-neotest/neotest",
  keys = {
    { "<leader>tr", function() require("neotest").run.run() end,                     desc = "(r)un the nearest test" },
    { "<leader>tR", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "(R)un the current file" },
    { "<leader>tk", function() require("neotest").run.stop() end,                    desc = "(k)ill the nearest test" },
    { "<leader>ta", function() require("neotest").run.attach() end,                  desc = "(a)ttach to the nearest test" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "open (o)utput window" },
    { "<leader>ts", function() require("neotest").output_panel.open() end,           desc = "open output as (s)plit" },
    { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "run the test in (d)ebug mode" },

  },
  dependencies = {
    { "haydenmeade/neotest-jest" },
    { "olimorris/neotest-rspec" },
    { "nvim-neotest/neotest-python" },
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
        require("neotest-python"),
        require("rustaceanvim.neotest"),
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
