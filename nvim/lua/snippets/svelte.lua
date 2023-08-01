local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
-- local t = ls.text_node
-- local d = ls.dynamic_node
-- local c = ls.choice_node
-- local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("svelte", {
  s("comp", fmt([[<script lang="ts">
  // scripts
</script>

{}

<style>
  /* styles */
</style>
]], { i(0) })),
})
