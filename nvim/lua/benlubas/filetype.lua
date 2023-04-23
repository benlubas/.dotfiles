vim.filetype.add({
  extension = {
    md = "markdown",
    es6 = "javascript",
  },
  pattern = {
    [".*/i3/.*"] = "i3config",
  },
})
