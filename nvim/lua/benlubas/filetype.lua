vim.filetype.add({
  extension = {
    md = "markdown",
    es6 = "javascript",
    keymap = "dts",
  },
  pattern = {
    [".*/i3/.*"] = "i3config",
  },
})
