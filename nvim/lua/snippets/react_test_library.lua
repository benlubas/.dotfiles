local ls = require("luasnip")

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  -- debug
  s("sd", fmt([[screen.debug({});]], { i(0) })),

  -- user
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
    fmt([[expect({}){}{};{}]], {
      i(1),
      c(2, { t(""), t(".not") }),
      c(3, { t(""), t(".toBeVisible()"), t(".toBeInTheDocument()") }),
      i(0),
    })
  ),

  -- by role
  s(
    "gr",
    fmt([[{}ByRole('{}', {{ name: {}{}}}){}]], {
      c(4, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { t("button"), t("checkbox"), t("textbox"), t("radio"), t("") }),
      c(2, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      c(3, { t(" "), t(", checked: true "), t(", checked: false ") }),
      i(0),
    })
  ),

  s(
    "gar",
    fmt([[{}AllByRole('{}', {{ name: {}{}}}){}]], {
      c(4, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { t("button"), t("checkbox"), t("textbox"), t("radio"), t("") }),
      c(2, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      c(3, { t(" "), t(", checked: true "), t(", checked: false ") }),
      i(0),
    })
  ),

  -- by text
  s(
    "gt",
    fmt([[{}ByText({}{}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      c(3, { t(""), fmt(", {{ selector: '{}' }}", { i(1) }) }),
      i(0),
    })
  ),
  s(
    "gat",
    fmt([[{}AllByText({}{}){}]], {
      c(2, { t("screen.get"), t("await screen.find"), t("screen.query") }),
      c(1, { fmt("/{}/i", { i(1) }), fmt("'{}'", { i(1) }), fmt("`{}`", { i(1) }), t("") }),
      c(3, { t(""), fmt(", {{ selector: '{}' }}", { i(1) }) }),
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
      [[it('{}', {}() => {{
  {}
}});]],
      {
        i(1),
        c(2, { t(""), t("async ") }),
        i(0),
      }
    )
  ),
})

ls.filetype_extend("javascript", { "javascriptreact" })
ls.filetype_extend("javascript", { "html" })
