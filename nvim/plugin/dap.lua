return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- open dap automatically (auto close was missfiring, use <leader>.u to toggle ui)
			require("dap").listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end
		end,
		keys = {
			{ "<leader>.b", require("dap").toggle_breakpoint },
			{ "<leader>.r", require("dap").continue, desc = "run the debugger, or run the code" },
			{ "<leader>.s", require("dap").step_over, desc = "step over" },
			{ "<leader>.S", require("dap").step_into, desc = "Step into" },
		},
	},
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{
		"rcarriga/nvim-dap-ui",
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
				-- Requires Neovim nightly (or 0.8 when released)
				enabled = true,
				-- Display controls in this element
				element = "repl",
				icons = {
					pause = "",
					play = "",
					step_into = "",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "↻",
					terminate = "□",
				},
			},
		},
		keys = {
			{ "<leader>.u", require("dapui").toggle, desc = "toggle the ui" },
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
