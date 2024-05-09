local Hydra = require("hydra")

local dap_hint = [[
^              DAP
^
-------------Setup---------
_t_: Toggle UI
_S_: Stop Debugger
_e_: Open DAP REPL
^
-----------Navigation------
_r_: Run/Continue execution
_j_: Step INTO code block
_l_: Step OVER code block
_k_: Step OUT of code block
^
-----------Breakpoint------
_b_: Toggle Breakpoint
_c_: Conditional Breakpoint
^
---------------------------
_<Esc>_: Close this window
_?_: Toggle this help
_q_: Quit
]]

local dap_hydra

dap_hydra = Hydra({
  name = "DAP",
  mode = { "n", "v" },
  config = {
    color = "pink",
    hint = {
      type = "window",
      position = "middle-right",
      float_opts = {
        border = "none",
      },
      hide_on_load = true,
    },
    silent = true,
  },
  hint = dap_hint,

  heads = {
    { "t", function() require("dapui").toggle() end },
    { "b", function() require("dap").toggle_breakpoint() end },
    { "c",
      function()
        vim.ui.input({ prompt = "Condition: " }, function(output)
          if output then require("dap").set_breakpoint(output) end
        end)
      end,
    },
    { "r", function() require("dap").continue() end },
    { "S",
      function()
        local dap = require("dap")
        dap.terminate({}, {
          terminateDebugee = true,
        }, function()
          dap.close()
        end)
      end },
    { "k", function() require("dap").step_out() end },
    { "l", function() require("dap").step_over() end },
    { "j", function() require("dap").step_into() end },
    {
      "i",
      function()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
        local dap = require("dap")
        if filetype == "" then
          filetype = "nil"
        end
        if dap and dap.launch_server and dap.launch_server[filetype] then
          dap.launch_server[filetype]()
        else
          vim.notify(string.format("No DAP Launch server configured for filetype %s", filetype), vim.log.levels.WARN)
        end
      end,
    },
    { "e", function() require("dap").repl.open() end },
    {
      "?",
      function()
        if dap_hydra.hint.win then
          dap_hydra.hint:close()
        else
          dap_hydra.hint:show()
        end
      end,
    },
    { "<Esc>", nil, { exit = true } },
    { "q", nil, { exit = true } },
  },
})
