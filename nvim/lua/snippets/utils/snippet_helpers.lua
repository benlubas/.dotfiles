local ls = require("luasnip")
-- local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node
-- local rep = require("luasnip.extras").rep
-- local k = require("luasnip.nodes.key_indexer").new_key
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}
M.i = 0

M.js_quotes = function(index)
  M.i = M.i + 1
  return c(index, { fmt("'{}'", { r(1, M.i) }), fmt("`{}`", { r(1, M.i) }), fmt('"{}"', { r(1, M.i) }), t("") })
end

M.js_selector = function(index)
  return c(index, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") })
end

M.rtl_selector = function(index)
  return c(index, { t("screen.get"), t("await screen.find"), t("screen.query") })
end

M.tracked_i_nodes = {}

M.tin = function(index, key)
  if not M.tracked_i_nodes[key] then
    M.tracked_i_nodes[key] = i(index)
  end
  return M.tracked_i_nodes[key]
end

return M
