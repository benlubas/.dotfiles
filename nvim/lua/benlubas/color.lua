-- I use custom colors in a lot of places, so this lets me set them from one place with easy names
-- and then change themes fairly easily. I do use highlight links when I can, but sometimes those
-- don't look good across themes.

local Themes = {}

---@alias HiGroup string A Highlight Group

---@class HiTable
---@field bg string?
---@field fg string?
---@field link string?

---@class TelescopeTheme
---@field main string
---@field prompt string
---@field title HiTable
---@field promptPrefix string
---@field pipe string
---@field charDev string
---@field block string
---@field read string
---@field user string
---@field group string
---@field constant string
---@field number string

---@class NeorgTheme
---@field heading1 HiGroup
---@field heading2 HiGroup
---@field heading3 HiGroup
---@field heading4 HiGroup
---@field heading5 HiGroup
---@field heading6 HiGroup

---@class StatusLineTheme
---@field normal string
---@field visual string
---@field insert string
---@field replace string
---@field commandline string
---@field terminal string
---@field inactive string
---@field branch HiTable
---@field diff_bg string
---@field added string
---@field changed string
---@field removed string
---@field search_count HiTable
---@field molten HiTable
---@field filetype HiTable
---@field position HiTable
---@field scroll HiTable
---@field hydra table

---@class Theme
---@field background string
---@field telescope TelescopeTheme
---@field neorg NeorgTheme
---@field status_line StatusLineTheme

local moonfly = require("moonfly").palette
---@type Theme
Themes["moonfly"] = {
  background = moonfly.black,
  telescope = {
    main = moonfly.grey233,
    prompt = moonfly.grey234,
    title = { bg = moonfly.blue, fg = moonfly.black },
    promptPrefix = "MoonflyBlue",
    pipe = "MoonflyBlue",
    charDev = "MoonflyBlue",
    block = "MoonflyBlue",
    read = "MoonflyBlue",
    user = "MoonflyBlue",
    group = "MoonflyBlue",
    constant = "MoonflyBlue",
    number = "MoonflyBlue",
  },
  status_line = {
    normal = moonfly.blue,
    visual = moonfly.purple,
    insert = moonfly.normal,
    replace = moonfly.crimson,
    commandline = moonfly.khaki,
    terminal = moonfly.orchid,
    inactive = moonfly.grey,
    branch = { fg = moonfly.blue, bg = moonfly.grey236 },
    diff_bg = moonfly.grey233,
    added = moonfly.emerald,
    changed = moonfly.blue,
    removed = moonfly.red,
    search_count = { bg = moonfly.grey233, fg = moonfly.orchid },
    molten = { bg = moonfly.grey233, fg = moonfly.red },
    filetype = { bg = "#4e4e4e" },
    position = { link = moonfly.blue },
    scroll = { bg = moonfly.blue, fg = moonfly.grey235 },
    hydra = {
      mode = { bg = moonfly.red, fg = moonfly.black },
      name = { bg = moonfly.grey236, fg = moonfly.red },
    },
  },
  neorg = {
    heading1 = "+MoonflyCrimson",
    heading2 = "+MoonflyBlue",
    heading3 = "+MoonflyKhaki",
    heading4 = "+MoonflyOrchid",
    heading5 = "+MoonflyCoral",
    heading6 = "+MoonflyEmerald",
  },
}

local default_theme = Themes["moonfly"]
return Themes[vim.g.colors_name] or default_theme
