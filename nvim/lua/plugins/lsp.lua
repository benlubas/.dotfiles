-- list of servers that will automatically be installed and setup with defaults
-- to add custom settings, just call setup again after the for loop
local servers = {
  "clangd",
  "cssls",
  "html",
  "emmet_ls",
  "pyright",
  "jsonls",
  -- 'ltex',
  "marksman",
  "rust_analyzer",
  "tsserver",
  "lua_ls",
  "clojure_lsp",
  -- "svelte",
}

return {
  -- { "evanleck/vim-svelte" },
  { "williamboman/mason.nvim", config = true },
  { "j-hui/fidget.nvim", config = true },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      {
        "<leader>do",
        vim.diagnostic.open_float,
        desc = "open diagnostic on current line",
      },
      { "<leader>dp", vim.diagnostic.goto_prev, desc = "open previous diagnostic" },
      { "<leader>dn", vim.diagnostic.goto_next, desc = "open next diagnostic" },
      { "H", vim.lsp.buf.hover, desc = "open hover information" },
    },
    dependencies = {
      {
        "folke/neodev.nvim",
        ft = "lua",
        opts = {
          setup_jsonls = false,
        },
      },
      { "simrat39/rust-tools.nvim" },
    },
    config = function()
      -- adding autocomplete capabilities...
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local other = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, other)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, other)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, other)

        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, other)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, other)
        vim.keymap.set("n", "<leader>l", vim.lsp.buf.code_action, other)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, other)
        vim.keymap.set("n", "<leader>gf", function()
          vim.lsp.buf.format({ async = true })
        end, other)
      end

      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      require("lspconfig")["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "require" },
            },
          },
        },
      })

      require("lspconfig")["tsserver"].setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = nil
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      require("lspconfig")["solargraph"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("rust-tools").setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "javascriptreact", "typescriptreact" },
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
        },
        on_attach = function(client, _)
          if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set("n", "<leader>gf", function()
              vim.lsp.buf.format({ async = true })
            end)
          end

          if client.server_capabilities.documentRangeFormattingProvider then
            vim.keymap.set("v", "<leader>gf", function()
              vim.lsp.buf.format({ async = true })
            end)
          end
        end,
      })
    end,
  },
}
