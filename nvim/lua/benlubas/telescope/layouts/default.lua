---Define a custom layout for telescope. It's basically a vertical layout with better borders and
---resizing.
---@param picker any
---@return unknown
return function(picker)
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")
  local TSLayout = require("telescope.pickers.layout")

  local border = {
    results = {
      top_left = "",
      top = "",
      top_right = "",
      right = "█",
      bottom_right = "▀",
      bottom = "▀",
      bottom_left = "▀",
      left = "█",
    },
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
    preview = {
      top_left = "▄",
      top = "▄",
      top_right = "▄",
      right = "█",
      bottom_right = "",
      bottom = "",
      bottom_left = "",
      left = "█",
    },
  }

  local results = Popup({
    focusable = false,
    border = {
      style = border.results,
      text = {
        top = picker.results_title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:TelescopeResultsNormal,FloatBorder:TelescopeResultsBorder",
    },
  })

  local prompt = Popup({
    enter = true,
    border = {
      style = border.prompt,
      text = {
        top = picker.prompt_title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptBorder",
    },
  })

  local preview = Popup({
    focusable = false,
    border = {
      style = border.preview,
      text = {
        -- TODO: set preview title to file name
        top = picker.preview_title,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:TelescopePreviewNormal,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle",
    },
  })

  local box = Layout.Box({
    Layout.Box(preview, { grow = 5 }),
    Layout.Box(prompt, { size = 3 }),
    Layout.Box(results, { grow = 6 }),
  }, { dir = "col" })

  local function prepare_layout_parts(layout)
    layout.results = TSLayout.Window(results) ---@diagnostic disable-line: param-type-mismatch
    layout.prompt = TSLayout.Window(prompt) ---@diagnostic disable-line: param-type-mismatch
    layout.preview = TSLayout.Window(preview) ---@diagnostic disable-line: param-type-mismatch
  end

  local layout = Layout({
    relative = "editor",
    position = {
      row = 2,
      col = "50%",
    },
    size = {
      height = "65%",
      width = "70%",
    },
  }, box)

  layout.picker = picker
  prepare_layout_parts(layout)

  local layout_update = layout.update
  function layout:update()
    prepare_layout_parts(layout)
    layout_update(self)
  end

  return TSLayout(layout)
end
