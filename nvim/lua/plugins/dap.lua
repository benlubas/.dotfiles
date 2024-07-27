return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- open dap automatically (auto close was missfiring, use <leader>.u to toggle ui)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end

      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      end

      -- highlight groups for nvim dap icons
      vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "MoonflyRed" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { link = "MoonflyCrimson" })
      vim.api.nvim_set_hl(0, "DapStopped", { link = "MoonflyEmerald" })

      vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
    end,
    keys = {
      { "<leader>.b", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>.c", function()
        vim.ui.input({ prompt = "Conditional Breakpoint: " }, function(input)
          require("dap").toggle_breakpoint(input)
        end)
      end },
      { "<leader>.r", function() require("dap").continue() end, desc = "run the debugger, or run the code" },
      { "<leader>.s", function() require("dap").step_over() end, desc = "step over" },
      { "<leader>.S", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>.nv", function() require("osv").launch({ port = 8086 }) end, desc = "Launch osv nvim debugger" },
    },
  },
  { "theHamsta/nvim-dap-virtual-text", config = true, lazy = true },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  --   opts = {
  --     ensure_installed = { "codelldb" },
  --     handlers = {},
  --   },
  -- },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {
        "<leader>.u",
        function()
          require("dapui").toggle()
        end,
        desc = "toggle the ui",
      },
    },
    config = function()
      require("dapui").setup({
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              "breakpoints",
              "stacks",
              "scopes",
            },
            size = 38, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "watches",
            },
            size = 0.24, -- 24% of total lines
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "",
          },
        },
      })
    end,
  },
  -- {
  --   "mxsdev/nvim-dap-vscode-js",
  --   config = function()
  --     require("dap-vscode-js").setup({
  --       -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  --       debugger_path = os.getenv("HOME") .. "/dev/microsoft/js-debug", -- Path to vscode-js-debug installation.
  --       -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  --       adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
  --       -- other adapters that I'm not using right now: ` 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost'
  --     })
  --
  --     for _, language in ipairs({ "typescript", "javascript" }) do
  --       require("dap").configurations[language] = {
  --         {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Debug Jest Tests",
  --             -- trace = true, -- include debugger info
  --             runtimeExecutable = "node",
  --             runtimeArgs = {
  --               "./node_modules/jest/bin/jest.js",
  --               "--runInBand",
  --             },
  --             rootPath = "${workspaceFolder}",
  --             cwd = "${workspaceFolder}",
  --             console = "integratedTerminal",
  --             internalConsoleOptions = "neverOpen",
  --           },
  --         },
  --       }
  --     end
  --   end,
  -- },
}
