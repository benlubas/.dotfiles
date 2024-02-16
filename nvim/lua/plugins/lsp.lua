-- list of servers that will automatically be setup with defaults (NOT INSTALLED)
-- to add custom settings, just call setup again after the for loop
local servers = {
  "bashls",
  "clangd",
  "clojure_lsp",
  -- "cssls",
  "emmet_language_server",
  "html",
  "lua_ls",
  -- "marksman",
  "pyright", -- it's the best b/c it's the only one that gives me auto complete, even tho it's really slow
  "rust_analyzer",
  "r_language_server",
  "svelte",
  "tsserver",
  "typst_lsp",
}

return {
  { "leafOfTree/vim-svelte-plugin" },
  { "williamboman/mason.nvim", config = true },
  {
    "j-hui/fidget.nvim",
    config = true,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      action_keys = {
        hover = "H",
      },
      auto_close = true,
    },
    keys = {
      { "<leader>xx", function() require("trouble").toggle() end, desc = "trouble" },
      { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "trouble all diagnostics" },
      { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, desc = "trouble doc diagnostics" },
      { "<leader>xq", function() require("trouble").toggle("quickfix") end, desc = "trouble quickfix" },
      { "<leader>xl", function() require("trouble").toggle("loclist") end, desc = "trouble loclist" },
      { "gR", function() require("trouble").toggle("lsp_references") end, desc = "trouble lsp references" },
    },
  },
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
      { "H",          vim.lsp.buf.hover,        desc = "open hover information" },
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
      -- capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

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
              globals = { "vim", "require", "P", "R" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      require("lspconfig")["tsserver"].setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = function()
            return {}
          end
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      require("lspconfig")["pyright"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedExpression = "none", -- this removes a really annoying warning in notebook type files
              },
              -- diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      -- require("lspconfig")["solargraph"].setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      require("rust-tools").setup({
        server = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
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
          null_ls.builtins.formatting.typstfmt,
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
