local nnoremap = require('benlubas.keymap').nnoremap
local dap = require('dap')
local dapui = require('dapui')

-- keybinds  using <leader>. as the prefix.
nnoremap('<leader>.b', dap.toggle_breakpoint)
nnoremap('<leader>.r', dap.continue) -- run the debugger, or run the code
nnoremap('<leader>.s', dap.step_over) -- step over
nnoremap('<leader>.S', dap.step_into) -- Step into
nnoremap('<leader>.u', dapui.toggle) -- toggle the ui

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = os.getenv('HOME') .. "/dev/microsoft/js-debug", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node' }, -- which adapters to register in nvim-dap
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
      }
    }
  }
end


require("nvim-dap-virtual-text").setup()
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
})

-- open dap automatically (auto close was missfiring, use <leader>.u to toggle ui) 
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end


