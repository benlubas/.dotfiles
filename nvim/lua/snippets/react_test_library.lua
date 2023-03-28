local ls = require("luasnip")

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
-- local d = ls.dynamic_node
local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  -- user
  s("clic", fmt([[await user.click({});]], {i(0)})),
  s("typ", fmt([[await user.type({}, '{}');]], {i(1), i(0)})),
  s("replace", fmt([[
await user.tripleClick({});
await user.keyboard('{}');
{}
]], {
      i(1), i(2), c(t("await user.click(document.body);"), t(""))
    })),

  -- get by role
  s("grb", fmt([[screen.getByRole('button', { name: /{}/i })]], {})),
  s("grc", fmt([[screen.getByRole('checkbox', { name: /{}/i })]], {})),
  s("grt", fmt([[screen.getByRole('textbox', { name: /{}/i })]], {})),

  -- find by role
  s("frb", fmt([[await screen.findByRole('button', { name: /{}/i })]], {})),
  s("frc", fmt([[await screen.findByRole('checkbox', { name: /{}/i })]], {})),
  s("frt", fmt([[await screen.findByRole('textbox', { name: /{}/i })]], {})),

  -- get all by role
  s("garb", fmt([[screen.getAllByRole('button', { name: /{}/i })]], {})),
  s("garc", fmt([[screen.getAllByRole('checkbox', { name: /{}/i })]], {})),
  s("gart", fmt([[screen.getAllByRole('textbox', { name: /{}/i })]], {})),

  -- query by role
  s("qrb", fmt([[screen.queryByRole('button', { name: /{}/i })]], {})),
  s("qrc", fmt([[screen.queryByRole('checkbox', { name: /{}/i })]], {})),
  s("qrt", fmt([[screen.queryByRole('textbox', { name: /{}/i })]], {})),

  -- test id
  s("gt", fmt([[screen.getByTestId('{}')]], {})),
  s("gat", fmt([[screen.getAllByTestId('{}')]], {})),
  s("qt", fmt([[screen.queryByTestId('{}')]], {})),
})
