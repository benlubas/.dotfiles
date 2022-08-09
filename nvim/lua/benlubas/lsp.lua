-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
local nvim_lsp = require('lspconfig')


-- These are nice, but I'm probably going to forget they exist.
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Highlight word under cursor with vim-illuminate
  require('illuminate').on_attach(client)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local other = { noremap = true, silent = true, buffer = bufnr }
  -- okay, so these work when they're in here...
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, other)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, other)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, other)
  -- this error out:
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  -- but these don't? When I move them to the remap file they start to work
  -- again...
  -- TODO: fix the below binds
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, other)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, other) -- this doesn't work.
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, other) -- this also doesn't work.
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, other)
  -- leader fmt is the best bind out there.
  vim.keymap.set('n', '<leader>fmt', vim.lsp.buf.formatting, other) -- this also doesn't work.
end

nvim_lsp['pyright'].setup {
  on_attach = on_attach,
}

nvim_lsp['tsserver'].setup {}

nvim_lsp['svelte'].setup {}

nvim_lsp['sumneko_lua'].setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local rust_tools_opts = {
  tools = {
    autoSetHints = true,
    runnables = {
      use_telescope = true
    },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attaches to the buffer
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "H", rt.hover_actions.hover_actions, { buffer = bufnr })
    end,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  },
}
require('rust-tools').setup(rust_tools_opts)
