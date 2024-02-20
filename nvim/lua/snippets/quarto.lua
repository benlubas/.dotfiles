local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
-- local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmta
-- local h = require("snippets.snippet_helpers")

ls.add_snippets("quarto", {
  -- code cell
  s(
    "`",
    fmt(
      [[```{<lang>}
<last>
``]],
      {
        lang = c(1, { t("python"), t("") }),
        last = i(0),
      }
    )
  ),
})
