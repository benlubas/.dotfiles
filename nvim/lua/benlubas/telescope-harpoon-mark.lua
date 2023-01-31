local Path = require("plenary.path")
local local_utils = require("benlubas.util")
local telescope_utils = require("telescope.actions.utils")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")

M = {}

M.mark_file = function(tb)
  actions.drop_all(tb)
  actions.add_selection(tb)
  telescope_utils.map_selections(tb, function(selection)
    local file = selection[1]
    pcall(require("harpoon.mark").add_file, file)
  end)
  actions.remove_selection(tb)
end

-- Telescope picker for importing harpoon branch marks from other branches for the same project
M.harpoon_branch_marks_picker = function(opts)
  P(require("harpoon").get_harpoon_config().mark_branch)

  if not require("harpoon").get_global_settings().mark_branch then
    print("import_branch_marks() requires 'mark_branch = true' in your harpoon config")
    return
  end

  -- Load the harpoon config file which contains all the project directories
  local config_path = vim.fn.stdpath("config")
  local user_config = string.format("%s/harpoon.json", config_path)
  local projects = vim.json.decode(Path:new(user_config):read()).projects

  -- get all the keys that match the form: ${cwd}-
  -- these are the branch keys that we should be able to load from.

  local cwd = vim.fn.getcwd()
  local picker_list = {}

  for key, value in pairs(projects) do
    if key:match(local_utils.escape_gsub(cwd .. "-")) then
      -- Add this to the list
      picker_list[key] = value
    end
  end

  -- the values are shaped like:
  -- {
  --   mark = {
  --     marks = {
  --       {
  --         row: int
  --         col: int
  --         filename: string
  --       }
  --     }
  --     term = {
  --       cmds = []
  --     }
  --   }
  -- }
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "branch marks",
      finder = finders.new_table({
        results = picker_list,
        entry_maker = function(entry)
          P(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          -- print(vim.inspect(selection))
          vim.api.nvim_put({ selection[1] }, "", false, true)
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

-- M.harpoon_branch_marks_picker()

return M
