vim.filetype.add({
  extension = {
    md = "quarto.markdown",
    es6 = "javascript",
    keymap = "dts",
  },
  pattern = {
    [".*/i3/.*"] = "i3config",
  },
})
