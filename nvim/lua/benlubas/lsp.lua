-- list of servers that will automatically be installed and setup with defaults
-- to add custom settings, just call setup again after the for loop
local servers = {
  'clangd',
  'pyright',
  'jdtls',
  'jsonls',
  -- 'ltex',
  'marksman',
  'rust_analyzer',
  'tsserver',
  'sumneko_lua',
  'svelte',
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- use this first one a good bit but the second might as well not exist.
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts) -- idk what this does but it 
-- conflicts with my quit bind. so. 


-- adding autocomplete capabilities...
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local other = { noremap = true, silent = true, buffer = bufnr }
  -- okay, so these work when they're in here...
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, other)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, other)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, other)
  -- this error out:
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, other)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, other)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, other) -- this also doesn't work.
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, other)
  -- leader gf is the best bind out there.
  vim.keymap.set('n', '<leader>gf', vim.lsp.buf.formatting, other)
end

require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('rust-tools').setup {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
}

require('lspconfig')['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
