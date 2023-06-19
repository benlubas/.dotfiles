--- File for a few random auto commands that don't fit elsewhere

-- I have other auto commands in:
-- color.lua - highlight on yank

-- when in a comment and you press o to go into a new line, don't make that line a comment line.
local comment_group = vim.api.nvim_create_augroup("fix comment enter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
    vim.opt.formatoptions:append({ "c" })
  end,
  group = comment_group,
  pattern = "*",
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- TODO: I'm not sure what's wrong here, the synconcealed function doesn't get triggered ever.
-- Only un-conceal when you're hovering text that is concealed
-- local word_conceal_group = vim.api.nvim_create_augroup("WordConceal", { clear = true })
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   callback = function(ev)
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     local concealed, _, _ = P(vim.fn.synconcealed(cursor_pos[1], cursor_pos[2]))
--
--     if concealed == 1 then
--       vim.opt_local.concealcursor = "c"
--     else
--       vim.opt_local.concealcursor = "nc"
--     end
--   end,
--   group = word_conceal_group,
--   pattern = { "*" },
-- })
