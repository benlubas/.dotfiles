local Path = require("plenary.path")
local local_utils = require("benlubas.util")
local telescope_utils = require("telescope.actions.utils")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

M = {}

M.mark_file = function(tb)
  actions.drop_all(tb)
  actions.add_selection(tb)
  telescope_utils.map_selections(tb, function(selection)
    local file = selection[1]

    -- This lets it work with live grep picker
    if selection.filename then
      file = selection.filename
    end

    -- this lets it work with git status picker
    if selection.value then
      file = selection.filename
    end

    pcall(require("harpoon.mark").add_file, file)
  end)
  actions.remove_selection(tb)
end

local format_marks = function(marks)
  local out = {}

  for _, m in ipairs(marks) do
    table.insert(out, m.filename)
  end

  return out
end

-- Telescope picker for importing harpoon branch marks from other branches for the same project
M.harpoon_branch_marks_picker = function(opts)
  if not require("harpoon").get_global_settings().mark_branch then
    print("warning, 'mark_branch = false' is set in harpoon config")
  end

  local data_path = vim.fn.stdpath("data")

  -- Load the harpoon config file which contains all the project directories
  local user_config = string.format("%s/harpoon.json", data_path)
  ---@diagnostic disable-next-line: undefined-field
  local projects = vim.json.decode(Path:new(user_config):read()).projects

  -- get all the keys that match the form: ${cwd}-
  -- these are the branch keys that we should be able to load from.

  local cwd = vim.fn.getcwd()
  local picker_list = {}

  for key, value in pairs(projects) do
    if string.match(key, local_utils.escape_gsub(cwd .. "-")) then
      -- Add this to the list
      table.insert(picker_list, { [key] = value })
    end
  end
  opts = opts or require("telescope.themes").get_dropdown({})
  pickers
    .new(opts, {
      prompt_title = "branch",
      finder = finders.new_table({
        results = picker_list,
        entry_maker = function(entry)
          for path, marks in pairs(entry) do
            local s = string.gsub(path, local_utils.escape_gsub(cwd .. "-"), "")
            local fmt = format_marks(marks.mark.marks)
            return {
              value = fmt,
              display = s,
              ordinal = s,
            }
          end
        end,
      }),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          for _, value in ipairs(selection.value) do
            require("harpoon.mark").add_file(value)
          end
        end)
        return true
      end,
      sorter = conf.generic_sorter(opts),
      previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry, _)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, entry.value)
        end,
        title = "Harpoon Marks",
      }),
    })
    :find()
end

return M
