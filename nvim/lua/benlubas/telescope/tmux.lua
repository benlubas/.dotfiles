local Path = require("plenary.path")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")

-- telescope picker for tmux

local M = {}

---telescope picker for project directories, similar to tmux-sessionizer
---@param project_paths table paths to find project directories at
---@param opts table? telescope picker options
M.tmux_sessions_picker = function(project_paths, opts)
  local picker_list = {}

  local paths_as_string = ""
  for _, value in ipairs(project_paths) do
    -- make sure this is a valid path, and then find all the sub dirs
    local path = Path:new(value):expand()
    path = Path:new(path)
    if not path:is_dir() then
      vim.notify("[telescope sessionizer] expected a directory, given " .. value)
      break
    end
    paths_as_string = paths_as_string .. path .. " "
  end

  -- list sub directories
  local dirs = io.popen("find " .. paths_as_string .. " -mindepth 1 -maxdepth 1 -type d"):lines()
  for dir_path in dirs do
    table.insert(picker_list, dir_path)
  end

  P(picker_list)

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
          os.execute("tmux_sessionizer " .. selection[1])
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
      previewer = nil,
    })
    :find()
end

return M
