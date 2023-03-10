return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- open dap automatically (auto close was missfiring, use <leader>.u to toggle ui)
			require("dap").listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end

      -- highlight groups for nvim dap icons
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF3939" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#80EFBE" })

      -- also, amogus symbol b/c it's funny
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "āļ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "ī", texthl = "DapLogPoint", numhl = "DapLogPoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "ī", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
		end,
		keys = {
			{ "<leader>.b", function() require("dap").toggle_breakpoint() end , desc = "toggle breakpoint" },
			{ "<leader>.r", function() require("dap").continue() end, desc = "run the debugger, or run the code" },
			{ "<leader>.s", function() require("dap").step_over() end, desc = "step over" },
			{ "<leader>.S", function() require("dap").step_into() end, desc = "Step into" },
		},
	},
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{
		"rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{ "<leader>.u", function() require("dapui").toggle() end, desc = "toggle the ui" },
		},
		opts = {
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
						-- Elements can be strings or table with id and size keys.
						{ id = "scopes", size = 0.25 },
						"breakpoints",
						"stacks",
						"watches",
					},
					size = 40, -- 40 columns
					position = "left",
				},
				{
					elements = {
						"repl",
						"console",
					},
					size = 0.25, -- 25% of total lines
					position = "bottom",
				},
			},
			controls = {
				enabled = true,
				-- Display controls in this element
				element = "repl",
				icons = {
					pause = "ī",
					play = "ī",
					step_into = "īē",
					step_over = "īŧ",
					step_out = "īģ",
					step_back = "ī",
					run_last = "âģ",
					terminate = "âĄ",
				},
			},
		},
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = os.getenv("HOME") .. "/dev/microsoft/js-debug", -- Path to vscode-js-debug installation.
				-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
				-- other adapters that I'm not using right now: ` 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost'
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						{
							type = "pwa-node",
							request = "launch",
							name = "Debug Jest Tests",
							-- trace = true, -- include debugger info
							runtimeExecutable = "node",
							runtimeArgs = {
								"./node_modules/jest/bin/jest.js",
								"--runInBand",
							},
							rootPath = "${workspaceFolder}",
							cwd = "${workspaceFolder}",
							console = "integratedTerminal",
							internalConsoleOptions = "neverOpen",
						},
					},
				}
			end
		end,
	},
}
