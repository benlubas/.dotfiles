-- Neorg Customizations

-- IMPORTANT: This file is generated (tangled) from extras.norg. Please edit that
-- file instead of this one

-- Keybinds

local key_options = { silent = true, buffer = true }
local function m(m, r, l)
  vim.keymap.set(m, r, l, key_options)
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    m("n", "<localleader>R", ":Neorg return<CR>")
    m("i", "<M-CR>", "<Plug>(neorg.itero.next-iteration)")
    m("n", "<localleader>nm", ":Neorg inject-metadata<CR>")
    m("n", "u", function()
      require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd.undo()
      vim.api.nvim_win_set_cursor(0, pos)
    end)
    m("n", "U", function()
      require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd.redo()
      vim.api.nvim_win_set_cursor(0, pos)
    end)
    m("i", "-(", "- ( ) ")
    m("i", "*(", "* ( ) ")
    m("n", "<localleader>d", "<Plug>(core.tempus.insert-date)")
    m("i", "\\date", "<Plug>(core.tempus.insert-date-insert-mode)")

    m("n", "<localleader>lt", "<Plug>(core.pivot.toggle-list-type)")
    m("n", "<localleader>li", "<Plug>(core.pivot.invert-list-type)")

    m({ "o", "x" }, "iT", "<Plug>(core.text-objects.textobject.tag.inner)")
    m({ "o", "x" }, "aH", "<Plug>(core.text-objects.textobject.heading.outer)")
    m({ "o", "x" }, "iH", "<Plug>(core.text-objects.textobject.heading.inner)")
    m("n", "<up>", "<Plug>(core.text-objects.item_up)")
    m("n", "<down>", "<Plug>(core.text-objects.item_down)")

    -- Telescope mappings:
    m("n", "<localleader>bf", "<Plug>(neorg.telescope.backlinks.file_backlinks)")
    m("n", "<localleader>bh", "<Plug>(neorg.telescope.backlinks.header_backlinks)")

    m("n", "<localleader>fl", "<Plug>(neorg.telescope.find_linkable)")
    m("n", "<localleader>ff", "<Plug>(neorg.telescope.find_norg_files)")
    m("n", "<localleader>if", "<Plug>(neorg.telescope.insert_file_link)")
    m("n", "<localleader>il", "<Plug>(neorg.telescope.insert_link)")
    m("n", "<localleader>fh", "<Plug>(neorg.telescope.search_headings)")
    m("n", "<localleader>sw", "<Plug>(neorg.telescope.switch_workspace)")
  end
})

-- Save Folds

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  pattern = "*.norg",
  callback = function()
    vim.cmd.mkview({ mods = { emsg_silent = true } })
  end,
})

-- something new

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Load file view if available and enable view saving for real files",
  group = view_group,
  pattern = "*.norg",
  callback = function()
    vim.schedule(function()
      vim.cmd.loadview({ mods = { emsg_silent = true } })
    end)
  end,
})

-- Templates

local file_exists_and_is_empty = function(filepath)
  local file = io.open(filepath, "r") -- Open the file in read mode
  if file ~= nil then
    local content = file:read("*all") -- Read the entire content of the file
    file:close()                      -- Close the file
    return content == ""              -- Check if the content is empty
  else
    return false
  end
end

local function template(pattern, template_name, additional_pattern)
  vim.api.nvim_create_autocmd({ "BufNew", "BufNewFile" }, {
    desc = "Autoload template for notes/journal",
    pattern = pattern,
    callback = function(args)
      local index = "index.norg"
      vim.schedule(function()
        if additional_pattern then
          local m = { args.file:match(additional_pattern) }
          if not args.file:match(additional_pattern) then return end
        end
        if vim.fn.fnamemodify(args.file, ":t") == index then
          return
        end
        if args.event == "BufNewFile"
          or (args.event == "BufNew"
          and file_exists_and_is_empty(args.file)) then
          vim.api.nvim_cmd({
            cmd = "Neorg",
            args = { "templates", "fload", template_name },
          }, {})
        end
      end)
    end,
  })
end

-- Creating New Notes

--- Create a new thought, you will be prompted for the thought's name/file
--- path
local function new_thought()
  vim.schedule(function()
    vim.ui.input({ default = "thoughts/" }, function(text)
      require("neorg.modules.core.dirman.module").public.create_file(text)
    end)
  end)
end

--- Open or create the project note for the current project
local function project_note()
  -- get the current directory
  local cwd = vim.fn.getcwd()
  local proj_name = cwd:match("github/(.*)")
  if not proj_name then
    vim.notify("[Neorg-Projects] Not in a project.")
    return
  end
  local prefix = "~/notes/projects/" .. proj_name
  local _, exists = io.open(prefix .. ".norg", "r")
  if exists then
    vim.cmd.e(prefix .. ".norg")
  else
    require("neorg.modules.core.dirman.module").public.create_file(prefix)
  end
end


-- Testing

local get_carryover_todos = function()
  local queryString = [[
        (heading2
          (heading2_prefix)
          title: (_)
          content: (generic_list
                     (unordered_list1
                       state: (detached_modifier_extension [
                         (todo_item_undone)
                         (todo_item_pending)
                       ])
                       content: (_)
                     ) @list
                   ))
    ]]

  local todos = {}

  local buf = { vim.api.nvim_buf_get_name(0):match("(%d%d%d%d)/(%d%d)/(%d%d)%.norg$") }
  if not buf[1] then return {} end
  local time = os.time({ year = buf[1], month = buf[2], day = buf[3] })
  local yesterday = os.date("%Y/%m/%d", time - 86400)
  local ws_path = require("neorg.modules.core.dirman.module").public.get_current_workspace()
  ws_path = ws_path[2]
  local yesterday_path = ws_path .. "/journal/" .. yesterday .. ".norg"
  local f = io.open(yesterday_path, "r")
  if not f then
    return {}
  end
  local content = f:read("*a")

  local parser = vim.treesitter.get_string_parser(content, "norg")
  local tree = parser:parse()[1]
  local root = tree:root()
  local lang = parser:lang()
  local query = vim.treesitter.query.parse(lang, queryString)

  local i = 0
  ---@diagnostic disable-next-line: missing-parameter
  for _, matches, _ in query:iter_matches(root, 0) do
    local m = vim.treesitter.get_node_text(matches[1], content)
    m = m:match("^.*[^\n]")
    for _, line in ipairs(vim.split(m, "\n")) do
      if i > 0 then
        line = "   " .. line   -- just hard coding the correct indent for me. idk how to dynamically set this
      end
      table.insert(todos, line)
    end
    i = i + 1
  end
  return todos
end

-- Exports

return {
  template = template,
  new_thought = new_thought,
  project_note = project_note,
  get_carryover_todos = get_carryover_todos,
}