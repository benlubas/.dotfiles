
return {
  "Olical/conjure",
  setup = function ()
    -- this plugin is configured with global variables, :h conjure-config to see them

    -- local leader is `\` which is sym + c on my keyboard
    vim.g["conjure#mapping#eval_comment_current_form"] = "o"
  end,
}
