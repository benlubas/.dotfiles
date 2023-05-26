local ls = require("luasnip")
-- local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node
-- local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local M = {}

M.js_quotes = function (index)
  return c(index, { fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), fmt('"{}"', { i(1) }), t("") })
end

M.js_selector = function (index)
  return c(index, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") })
end

M.rtl_selector = function (index)
  return c(index, { t("screen.get"), t("await screen.find"), t("screen.query") })
end

return M
