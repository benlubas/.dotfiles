return {
  "kaarmu/typst.vim",
  ft = "typst",
  lazy = false,
  init = function()
    vim.g.typst_cmd = "typst" -- Specifies the location of the Typst executable.
    vim.g.typst_pdf_viewer = "firefox" -- Specifies pdf viewer that typst watch --open will use.
    vim.g.typst_conceal = 0 -- Enable concealment.
    vim.g.typst_auto_close_toc = 0 -- Specifies whether TOC will be automatically closed after using it.
    vim.g.typst_auto_open_quickfix = 0 -- Specifies whether the quickfix list should automatically open when there are errors from typst.
    -- vim.g.typst_embedded_languages = {} -- A list of languages that will be highlighted in code blocks. Typst is always highlighted.

    local colors = require("moonfly").palette
    vim.api.nvim_set_hl(0, "@lsp.type.heading.typst", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "@lsp.typemod.text.emph.typst", { fg = colors.orchid })
    vim.api.nvim_set_hl(0, "@lsp.typemod.text.strong.typst", { fg = colors.orchid })
  end,
}
