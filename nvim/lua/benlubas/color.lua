-- I use custom colors in a lot of places, so this lets me set them from one place with easy names
-- and then change themes fairly easily. I do use highlight links when I can, but sometimes those
-- don't look good across themes.

local Themes = {}

---@alias HiGroup string A Highlight Group

---@class TelescopeTheme
---@field main string
---@field prompt string
---@field title vim.api.keyset.highlight
---@field promptPrefix vim.api.keyset.highlight
---@field pipe vim.api.keyset.highlight
---@field charDev vim.api.keyset.highlight
---@field block vim.api.keyset.highlight
---@field read vim.api.keyset.highlight
---@field user vim.api.keyset.highlight
---@field group vim.api.keyset.highlight
---@field constant vim.api.keyset.highlight
---@field number vim.api.keyset.highlight

---@class NeorgTheme
---@field heading1 vim.api.keyset.highlight
---@field heading2 vim.api.keyset.highlight
---@field heading3 vim.api.keyset.highlight
---@field heading4 vim.api.keyset.highlight
---@field heading5 vim.api.keyset.highlight
---@field heading6 vim.api.keyset.highlight

---@class OilTheme
---@field executable string
---@field d string
---@field p string
---@field l string
---@field s string

---@class StatusLineTheme
---@field normal string
---@field visual string
---@field insert string
---@field replace string
---@field commandline string
---@field terminal string
---@field inactive string
---@field branch vim.api.keyset.highlight
---@field diff_bg string
---@field added string
---@field changed string
---@field removed string
---@field filename vim.api.keyset.highlight
---@field search_count vim.api.keyset.highlight
---@field molten vim.api.keyset.highlight
---@field filetype vim.api.keyset.highlight
---@field position vim.api.keyset.highlight
---@field scroll vim.api.keyset.highlight
---@field hydra table

---@class FloatTheme
---@field border vim.api.keyset.highlight
---@field window vim.api.keyset.highlight
---@field title vim.api.keyset.highlight

---@class HydraTheme
---@field red vim.api.keyset.highlight
---@field blue vim.api.keyset.highlight
---@field teal vim.api.keyset.highlight
---@field amaranth vim.api.keyset.highlight
---@field pink vim.api.keyset.highlight

---@class StarterTheme
---@field section vim.api.keyset.highlight
---@field query vim.api.keyset.highlight
---@field current vim.api.keyset.highlight
---@field header vim.api.keyset.highlight
---@field prefix vim.api.keyset.highlight

---@class Theme
---@field background string
---@field fancy_float FloatTheme
---@field harpoon_current string
---@field telescope TelescopeTheme
---@field neorg NeorgTheme
---@field status_line StatusLineTheme
---@field hydra HydraTheme
---@field starter StarterTheme
---@field oil OilTheme

local ok, moonfly = pcall(require, "moonfly")
if ok then
  moonfly = moonfly.palette
  ---@type Theme
  Themes["moonfly"] = {
    background = moonfly.black,
    fancy_float = {
      border = { fg = moonfly.grey233 },
      window = { bg = moonfly.grey233 },
      title = { bg = moonfly.blue, fg = moonfly.black },
    },
    harpoon_current = moonfly.orchid,
    telescope = {
      main = moonfly.grey233,
      prompt = moonfly.grey234,
      title = { bg = moonfly.blue, fg = moonfly.black },
      promptPrefix = { link = "MoonflyBlue" },
      pipe = { link = "MoonflyBlue" },
      charDev = { link = "MoonflyBlue" },
      block = { link = "MoonflyBlue" },
      read = { link = "MoonflyBlue" },
      user = { link = "MoonflyBlue" },
      group = { link = "MoonflyBlue" },
      constant = { link = "MoonflyBlue" },
      number = { link = "MoonflyBlue" },
    },
    hydra = {
      red = { link = "MoonflyRed" },
      blue = { link = "MoonflyBlue" },
      amaranth = { link = "MoonflyCranberry" },
      teal = { link = "MoonflyTurquoise" },
      pink = { link = "MoonflyCrimson" },
    },
    starter = {
      section = { link = "MoonflyBlue" },
      query = { link = "MoonflyCrimson" },
      current = { link = "MoonflyWhiteLineActive" },
      header = { link = "MoonflyGrey237" },
      prefix = { link = "MoonflyWhite" },
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
      ---@diagnostic disable-next-line: assign-type-mismatch
      filename = nil, -- whatever the default is is fine here.
      position = { link = moonfly.blue },
      scroll = { bg = moonfly.blue, fg = moonfly.grey235 },
      hydra = {
        mode = { bg = moonfly.red, fg = moonfly.black },
        name = { bg = moonfly.grey236, fg = moonfly.red },
      },
    },
    neorg = {
      heading1 = { fg = moonfly.crimson },
      heading2 = { fg = moonfly.blue },
      heading3 = { fg = moonfly.khaki },
      heading4 = { fg = moonfly.orchid },
      heading5 = { fg = moonfly.coral },
      heading6 = { fg = moonfly.emerald },
    },
    oil = {
      executable = "MoonflyBlue",
      d = "MoonflyBlue",
      p = "MoonflyCranberry",
      l = "MoonflyPurple",
      s = "MoonflyCranberry",
    },
  }
end

local fok, fox = pcall(require, "nightfox.palette")
if fok then
  fox = fox.load("carbonfox")
  ---@type Theme
  Themes["carbonfox"] = {
    background = fox.bg1,
    harpoon_current = fox.red.dim,
    fancy_float = {
      title = { bg = fox.cyan.dim, fg = fox.bg0 },
      border = { fg = fox.bg0, bg = fox.bg1 },
      window = { bg = fox.bg0 },
    },
    telescope = {
      main = fox.bg0,
      prompt = fox.bg2,
      title = { bg = fox.cyan.dim, fg = fox.fg1 },
      promptPrefix = { fg = fox.cyan.dim },
      pipe = { fg = fox.cyan.dim },
      charDev = { fg = fox.cyan.dim },
      block = { fg = fox.cyan.dim },
      read = { fg = fox.cyan.dim },
      user = { fg = fox.cyan.dim },
      group = { fg = fox.cyan.dim },
      constant = { fg = fox.cyan.dim },
      number = { fg = fox.cyan.dim },
    },
    hydra = {
      red = { fg = fox.red.dim },
      blue = { fg = fox.blue.base },
      amaranth = { fg = fox.red.bright },
      teal = { fg = fox.yellow.base }, -- it's not actually yellow
      pink = { fg = fox.pink.base },
    },
    starter = {
      section = { fg = fox.blue.base },
      query = { fg = fox.red.base },
      current = { bg = fox.bg4, fg = fox.white.base },
      header = { fg = fox.green.dim },
      prefix = { fg = fox.white.base },
    },
    status_line = {
      normal = fox.cyan.base,
      visual = fox.magenta.bright,
      insert = fox.white.dim,
      replace = fox.magenta.bright,
      commandline = fox.yellow.dim,
      terminal = fox.pink.dim,
      inactive = fox.bg4,
      branch = { fg = fox.cyan.base, bg = fox.bg2 },
      diff_bg = fox.bg1,
      added = fox.green.bright,
      changed = fox.blue.base,
      removed = fox.red.base,
      filename = { bg = fox.bg2 },
      search_count = { bg = fox.bg3, fg = fox.pink.bright },
      molten = { bg = fox.bg2, fg = fox.red.base },
      filetype = { bg = fox.bg4 },
      position = { link = fox.cyan.base, bg = fox.bg2 },
      scroll = { bg = fox.cyan.base, fg = fox.bg2 },
      hydra = {
        mode = { bg = fox.red.base, fg = fox.bg2 },
        name = { bg = fox.bg2, fg = fox.red.dim },
      },
    },
    ---@diagnostic disable-next-line: missing-fields
    neorg = {
      heading1 = { fg = fox.red.dim },
      heading2 = { fg = fox.blue.base },
      heading3 = { fg = fox.magenta.base },
      heading4 = { fg = fox.cyan.dim },
      heading5 = { fg = fox.green.bright },
      heading6 = { fg = fox.cyan.bright },
    },
    oil = {
      executable = "@field",
      d = "@constructor",
      p = "@constant.macro",
      l = "@exception",
      s = "@attribute",
    }
  }
end

local default_theme = Themes["moonfly"]
return Themes[vim.g.color_theme_name] or default_theme
