local Path = require("plenary.path")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")

-- telescope picker for tmux

local M = {}

---telescope picker for project directories, similar to tmux-sessionizer
---@param opts table? telescope picker options
M.tmux_sessionizer_picker = function(opts)
  local picker_list = {}

  for line in io.popen("tmux-sessionizer --options"):lines() do
    table.insert(picker_list, line)
  end

  opts = opts or require("telescope.themes").get_ivy({})
  pickers
    .new(opts, {
      prompt_title = "workspace",
      finder = finders.new_table({
        results = picker_list,
      }),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          os.execute("tmux-sessionizer " .. selection[1])
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
      previewer = nil,
    })
    :find()
end

M.tmux_sessions_picker = function(opts)
  local picker_list = {}

  -- list existing tmux sessions
  local sessions = io.popen("tmux list-sessions | awk -F \":\" '{ print($1) }'"):lines()
  for session in sessions do
    table.insert(picker_list, session)
  end

  opts = opts or require("telescope.themes").get_ivy({})
  pickers
    .new(opts, {
      prompt_title = "Session",
      finder = finders.new_table({
        results = picker_list,
      }),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          os.execute("tmux-sessionizer " .. selection[1])
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
      previewer = nil,
    })
    :find()
end

return M
