local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
-- local c = ls.choice_node
local f = ls.function_node
-- local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
-- local h = require("snippets.snippet_helpers")

local function swap(pattern)
  return s(
    {
      trig = pattern,
      trigEngine = "pattern",
      hidden = true,
    },
    fmta("<one><two><last>", {
      one = f(function(_, parent) return parent.snippet.captures[2] end),
      two = f(function(_, parent) return parent.snippet.captures[1] end),
      last = i(0),
    })
  )
end

ls.add_snippets("norg", {
  s(
    "code",
    fmta(
      [[@code <lang>
<last>
@end]],
      {
        lang = i(1),
        last = i(0),
      }
    )
  ),
  swap("({[^}]*})(%[[^%]]*%])"),
  swap("(%[[^%]]*%])({[^}]*})"),
})
