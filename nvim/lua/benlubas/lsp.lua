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
  'solargraph',
  'sorbet',
  'sumneko_lua',
  'svelte',
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- use this first one a good bit but the second might as well not exist.
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts) -- this is something that I don't use enough
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)


-- adding autocomplete capabilities...
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(bufopts, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local other = { noremap = true, silent = true, buffer = bufnr }
  -- okay, so these work when they're in here...
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, other)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, other)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, other)
  -- vim.keymap.set('n', '<leader>b', vim.lsp.buf.signature_help, bufopts) -- this doesn't always work
  -- I think this might be something that not all language servers have support for

  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, other)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, other)
  vim.keymap.set('n', '<leader>l', vim.lsp.buf.code_action, other) -- I need to use this more often
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, other)
  vim.keymap.set('n', '<leader>gf', function() vim.lsp.buf.format { async = true } end, other)
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

-- Null lsp (this is here for prettier)
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint, -- I think ts server has these now by default? idk, I was getting duplicates 
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.code_actions.gitsigns, -- this was just too much
    null_ls.builtins.formatting.prettier.with({ extra_filetypes = { "javascriptreact", "typescriptreact" } }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>gf :lua vim.lsp.buf.format{ async = true}<CR>")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>gf :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})
