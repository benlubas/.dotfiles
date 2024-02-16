vim.bo.tw = 85

vim.api.nvim_create_user_command("NeorgOtter", function()
  require("quarto").activate()

  local b = vim.api.nvim_get_current_buf()
  local function set(lhs, rhs)
    vim.api.nvim_buf_set_keymap(b, "n", lhs, rhs, { silent = false, noremap = true })
  end

  set("gd", ":lua require'otter'.ask_definition()<cr>")
  set("gt", ":lua require'otter'.ask_type_definition()<cr>")
  set("H", ":lua require'otter'.ask_hover()<cr>")
  set("<leader>rn", ":lua require'otter'.ask_rename()<cr>")
  set("gr", ":lua require'otter'.ask_references()<cr>")
  set("gs", ":lua require'otter'.ask_document_symbols()<cr>")
  set("<leader>gf", ":lua require'otter'.ask_format()<cr>")
end, {})
