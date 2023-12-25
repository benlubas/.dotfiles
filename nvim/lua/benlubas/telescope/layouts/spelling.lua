---Custom small selector for spelling suggestions
---@param picker any
---@return TelescopeLayout
return function(picker)
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")
  local TSLayout = require("telescope.pickers.layout")

  local results = Popup({
    focusable = false,
    border = { style = "none" },
    win_options = {
      winhighlight = "Normal:TelescopeResultsNormal",
    },
  })

  local prompt = Popup({
    enter = true,
    border = { style = "none" },
    win_options = {
      winhighlight = "Normal:TelescopePromptNormal",
    },
  })

  local box = Layout.Box({
    Layout.Box(results, { grow = 1 }),
    Layout.Box(prompt, { size = 1 }),
  }, { dir = "col" })

  local function prepare_layout_parts(layout)
    layout.results = TSLayout.Window(results) ---@diagnostic disable-line: param-type-mismatch
    layout.prompt = TSLayout.Window(prompt) ---@diagnostic disable-line: param-type-mismatch
    layout.preview = TSLayout.Window(nil) ---@diagnostic disable-line: param-type-mismatch
  end

  -- Little extra to always put the window at the start of the word we're replacing
  local word = vim.fn.expand("<cword>")
  local to_end = vim.api.nvim_eval([[matchstr(getline('.'), '\k*', getpos('.')[2]-1)]])
  local offset = #word - #to_end

  local layout = Layout({
    relative = "cursor",
    anchor = "NW",
    position = {
      row = 1,
      col = -offset - 2,
    },
    size = {
      height = 6,
      width = 20,
    },
  }, box)

  layout.picker = picker
  prepare_layout_parts(layout)

  local layout_update = layout.update
  ---@diagnostic disable-next-line: duplicate-set-field
  function layout:update()
    prepare_layout_parts(layout)
    layout_update(self)
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  return TSLayout(layout)
end
