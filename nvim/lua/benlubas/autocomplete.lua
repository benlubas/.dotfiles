-- File with all things related to auto complete (excluding the LSP server stuff itself)

local cmp = require('cmp')
local winhighlight = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(winhighlight),
    documentation = cmp.config.window.bordered(winhighlight),
  },
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-c>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  formatting = {
    format = require('lspkind').cmp_format(),
  },
  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'neorg' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- this plugin is sick
require('nvim-autopairs').setup()
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
