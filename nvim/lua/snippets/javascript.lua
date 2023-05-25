local ls = require("luasnip")

local s = ls.s
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  s("clg", fmt("console.log({});", {
    c(1, { i(0), fmt("'{}: ', {}", { rep(1), i(1) }) })
  })),
})

ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })
