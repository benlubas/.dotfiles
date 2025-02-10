local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local f = ls.function_node
local c = ls.choice_node

local r = ls.restore_node
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("rust", {
  s(
    "pr",
    fmta([[println!(<>);]], {
      c(1, { fmta('"<>: {<><>}"', { rep(1), r(1, "pr"), c(2, { t(""), t(":?") }) }), fmta('"<>"', { r(1, "pr") }) }),
    })
  ),

  s(
    "test",
    fmta(
      [[#[test]
fn <>() {
    <>
}]],
      { i(1), i(0) }
    )
  ),
})
