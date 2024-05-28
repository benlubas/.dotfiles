local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  s("pr", fmt("print({})", {
    c(1, { fmt('"{}:", {}', { rep(1), i(1) }), fmt('"{}"', i(1)) })
  })),
})
