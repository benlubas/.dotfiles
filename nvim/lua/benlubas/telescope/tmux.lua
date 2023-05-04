local Path = require("plenary.path")
local local_utils = require("benlubas.util")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

-- telescope picker for tmux

local M = {}

---telescope picker for project directories, similar to tmux-sessionizer
---@param project_paths table paths to find project directories at
---@param opts table telescope picker options
M.tmux_sessions_picker = function(project_paths, opts)
  local picker_list = {}

  for _, value in ipairs(project_paths) do
    -- make sure this is a valid path, and then find all the sub dirs
    local path = Path:new(value)
    if not path.is_dir() then
      vim.notify("[telescope sessionizer] expected a directory, given " .. path)
      break
    end

    -- list sub directories
    for dir_path in io.popen("find " .. path .. "-mindepth 1 -maxdepth 1 -type d") do
      picker_list:insert(dir_path)
    end
  end

  P(picker_list)

  opts = opts or require("telescope.themes").get_ivy({})
  pickers
    .new(opts, {
      prompt_title = "workspace",
      finder = finders.new_table({
        results = picker_list,
        entry_maker = function(entry)
          for path, marks in pairs(entry) do
            local s = string.gsub(path, local_utils.escape_gsub(cwd .. "-"), "")
            -- local fmt = format_marks(marks.mark.marks)
            local fmt = { "hi there", "these are the lines in the file" }
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
