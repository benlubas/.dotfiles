local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node

local r = ls.restore_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  s("pr", fmt("print({})", {
    c(1, { fmt('"{}:", {}', { rep(1), r(1, "pr") }), fmt('"{}"', { r(1, "pr") }) })
  })),

  ------ busted snippets -------
  s("des", fmt([[describe("{}", function()
  {}
end)]], { i(1), i(0) })),
  s("it", fmt([[it("{}", function()
  {}
end)]], { i(1), i(0) })),
})
