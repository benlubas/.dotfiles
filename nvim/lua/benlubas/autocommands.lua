--- File for a few random auto commands that don't fit elsewhere

-- I have other auto commands in:
-- color.lua - highlight on yank

-- when in a comment and you press o to go into a new line, don't make that line a comment line.
local comment_group = vim.api.nvim_create_augroup('fix comment enter', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({'o', 'r'})
    vim.opt.formatoptions:append({'c'})
  end,
  group = comment_group,
  pattern = '*',
})
