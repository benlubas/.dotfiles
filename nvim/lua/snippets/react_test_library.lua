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
  s("clic", fmt([[await user.click({});]], { i(0) })),
  s("typ", fmt([[await user.type({}, '{}');]], { i(1), i(0) })),

  -- get by role
  s("grb", fmt([[screen.getByRole('button', {{ name: /{}/i }})]], { i(0) })),
  s("grc", fmt([[screen.getByRole('checkbox', {{ name: /{}/i }})]], { i(0) })),
  s("grt", fmt([[screen.getByRole('textbox', {{ name: /{}/i }})]], { i(0) })),

  -- find by role
  s("frb", fmt([[await screen.findByRole('button', {{ name: /{}/i }})]], { i(0) })),
  s("frc", fmt([[await screen.findByRole('checkbox', {{ name: /{}/i }})]], { i(0) })),
  s("frt", fmt([[await screen.findByRole('textbox', {{ name: /{}/i }})]], { i(0) })),

  -- get all by role
  s("garb", fmt([[screen.getAllByRole('button', {{ name: /{}/i }})]], { i(0) })),
  s("garc", fmt([[screen.getAllByRole('checkbox', {{ name: /{}/i }})]], { i(0) })),
  s("gart", fmt([[screen.getAllByRole('textbox', {{ name: /{}/i }})]], { i(0) })),

  -- query by role
  s("qrb", fmt([[screen.queryByRole('button', {{ name: /{}/i }})]], { i(0) })),
  s("qrc", fmt([[screen.queryByRole('checkbox', {{ name: /{}/i }})]], { i(0) })),
  s("qrt", fmt([[screen.queryByRole('textbox', {{ name: /{}/i }})]], { i(0) })),

  -- test id
  s("gt", fmt([[screen.getByTestId('{}')]], { i(0) })),
  s("gat", fmt([[screen.getAllByTestId('{}')]], { i(0) })),
  s("qt", fmt([[screen.queryByTestId('{}')]], { i(0) })),
})
