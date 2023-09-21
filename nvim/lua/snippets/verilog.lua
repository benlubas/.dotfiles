local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local c = ls.choice_node
-- local f = ls.function_node
-- local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
-- local h = require("snippets.snippet_helpers")

ls.add_snippets("verilog", {
  s("mod", fmt([[module {}({});
  {}
endmodule]], { i(1), i(2), i(0) })),
})
