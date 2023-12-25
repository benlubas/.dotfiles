---Custom Ivy Layout, this just lets me customize it more
---@param picker any
---@return unknown
return function(picker)
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")
  local TSLayout = require("telescope.pickers.layout")

  local border = {
    prompt = {
      top_left = "▄",
      top = "▄",
      top_right = "▄",
      right = "█",
      bottom_right = "▀",
      bottom = "▀",
      bottom_left = "▀",
      left = "█",
    },
  }

  local results = Popup({
    focusable = false,
    border = { style = "none" },
    win_options = {
      winhighlight = "Normal:TelescopeResultsNormal",
    },
  })

  local prompt = Popup({
    enter = true,
    border = {
      style = border.prompt,
      text = {
        top = " " .. picker.prompt_title .. " ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder,FloatTitle:TelescopePromptTitle",
    },
  })

  local box = Layout.Box({
    Layout.Box(prompt, { size = 3 }),
    Layout.Box(results, { grow = 1 }),
  }, { dir = "col" })

  local function prepare_layout_parts(layout)
    layout.results = TSLayout.Window(results) ---@diagnostic disable-line: param-type-mismatch
    layout.prompt = TSLayout.Window(prompt) ---@diagnostic disable-line: param-type-mismatch
    layout.preview = TSLayout.Window(nil) ---@diagnostic disable-line: param-type-mismatch
  end

  local layout = Layout({
    relative = "editor",
    anchor = "SW",
    position = {
      row = vim.api.nvim_get_option("lines") - 2,
      col = 0,
    },
    size = {
      height = 12,
      width = "100%",
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
