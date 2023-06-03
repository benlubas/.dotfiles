local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("ruby", {
  s("it", fmt([[it "{}" do
  {}
end
    ]], { i(1), i(0) })),

  s("ex", fmt([[expect({}){}]], { i(1), i(0) })),
  s("pry", fmt([[binding.pry{}]], { i(0) })),
})
