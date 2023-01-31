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
    { "benlubas/neotest-rspec", dev = true },
  },
	config = function()
    require("neotest").setup({
      adapters = {
        -- these are the defaults
        require("neotest-jest")({
          jestCommand = "npm test --",
          env = { CI = true },
          cwd = function(_path)
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
          target = "t"
        },
        open = "botright vsplit | vertical resize 50"
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
    })
  end,
}

