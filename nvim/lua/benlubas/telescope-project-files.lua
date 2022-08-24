-- snippet to use git_files for file finding in git repos, and just normal find_files in others
-- b/c git_files is faster than find_files in git repos (apparently)

local M = {}

M.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M
