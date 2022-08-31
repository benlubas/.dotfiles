require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
  hide_cursor = false,
  stop_eof = false,
  post_hook = function() -- function to flash the line that we land on
    vim.opt.cul = true
    vim.defer_fn(function()
      vim.opt.cul = false
    end, 150)
  end,
})
require('which-key').setup()
require('nvim-web-devicons').setup()

vim.cmd('syntax enable')
vim.cmd[[colorscheme moonfly]]

vim.g.moonflyNormalFloat = true
vim.g.moonflyItalics = false

vim.cmd[[highlight CursorLine ctermbg=238 guibg=#111111]] -- this interferes with fold highlighting 
vim.cmd[[highlight Folded ctermfg=63 guifg=#2E5EDB ctermbg=236 guibg=#111111]]
vim.cmd[[highlight htmlBold gui=bold guifg=#af0000 ctermfg=124]]
vim.cmd[[highlight htmlItalic gui=italic guifg=#ff8700 ctermfg=214]]



-- boarders for the text that pops up for autocomplete and stuff
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signatureHelp, {
    border = "single"
  }
)

vim.diagnostic.config({ float = { border = "single" } })

-- Indentation
require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  -- show_current_context_start = true,
}

require('todo-comments').setup({
  highlight = {
    before = "fg",
    keyword = "bg",
    after = "",
  },
})

-- Highlight on yank 
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', require('benlubas.search_count').get_search_count},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
