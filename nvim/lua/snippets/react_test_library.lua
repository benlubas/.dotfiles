local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local h = require("snippets.snippet_helpers")

ls.add_snippets("javascript", {
  -- debug
  s("sd", fmt([[screen.debug({});]], { i(0) })),

  -- user
  s("usr", t("const user = userEvent.setup();")),
  s("cl", fmt([[await user.click({});]], { c(1, { t(""), t("document.body") }) })),
  s("typ", fmt([[await user.type({}, '{}');]], { i(1), i(0) })),
  s(
    "rep",
    fmt(
      [[
await user.tripleClick({});
await user.keyboard('{}');
{}
]],
      {
        i(1),
        i(2),
        c(3, { t("await user.click(document.body);"), t("") }),
      }
    )
  ),

  s(
    "ex",
    fmt([[expect({}){};{}]], {
      i(1),
      c(2, { t(""), t(".toBeVisible()"), t(".not.toBeInTheDocument()") }),
      i(0),
    })
  ),

  -- by role
  s(
    "gr",
    fmt([[{}ByRole('{}', {{ name: {}}}){}]], {
      c(3, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { t("button"), t("checkbox"), t("textbox"), t("radio"), t("") }),
      h.js_selector(2),
      i(0),
    })
  ),

  s(
    "gar",
    fmt([[{}AllByRole('{}', {{ name: {}}}){}]], {
      c(3, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { t("button"), t("checkbox"), t("textbox"), t("radio"), t("") }),
      h.js_selector(2),
      i(0),
    })
  ),

  -- by text
  s(
    "gt",
    fmt([[{}ByText({}{}){}]], {
      h.rtl_selector(2),
      h.js_selector(1),
      c(3, { t(""), fmt(", {{ selector: '{}' }}", { i(1) }) }),
      i(0),
    })
  ),

  s(
    "gat",
    fmt([[{}AllByText({}{}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      h.js_selector(1),
      c(3, { t(""), fmt(", {{ selector: '{}' }}", { i(1) }) }),
      i(0),
    })
  ),

  -- placeholder text
  s("gp",
    fmt([[{}ByPlaceholderText({}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      h.js_selector(1),
      i(0),
    })
  ),

  s("gap",
    fmt([[{}AllByPlaceholderText({}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      h.js_selector(1),
      i(0),
    })
  ),

  -- test id
  s(
    "gi",
    fmt([[{}ByTestId({}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { fmt("'{}'", { i(1) }), fmt("/{}/i", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      i(0),
    })
  ),
  s(
    "gai",
    fmt([[{}AllByTestId({}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { fmt("'{}'", { i(1) }), fmt("/{}/i", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      i(0),
    })
  ),

  -- it
  s(
    "it",
    fmt(
      [[it({}, {}() => {{
  {}
}});]],
      {
        h.js_quotes(1),
        c(2, { t(""), t("async ") }),
        i(0),
      }
    )
  ),
})
