local ls = require("luasnip")

local s = ls.snippet
-- local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local r = ls.restore_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  s("clg", fmt("console.log({});", {
    c(1, { fmt("'{}: ', {}", { rep(1), r(1, "var") }), r(0, "var") })
  })),
})

ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("svelte", { "javascript" })
ls.filetype_extend("norg", { "javascript" })
