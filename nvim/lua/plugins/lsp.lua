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
  "nil_ls",
  "r_language_server",
  "svelte",
  "taplo",
  "tsserver",
  "typst_lsp",
}

return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  { -- this is really useful when there are a ton of diagnostics for different parts of a single line
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      local lspl = require("lsp_lines")
      lspl.setup()
      lspl.toggle()

      local on = false
      vim.keymap.set("n", "<Leader>k", function()
        vim.diagnostic.config({ virtual_text = on })
        on = not on
        lspl.toggle()
      end, { desc = "Toggle lsp_lines" })
    end,
  },
  { "williamboman/mason.nvim", config = true },
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
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
        desc = "trouble",
      },
      {
        "<leader>xw",
        function()
          require("trouble").toggle("workspace_diagnostics")
        end,
        desc = "trouble all diagnostics",
      },
      {
        "<leader>xd",
        function()
          require("trouble").toggle("document_diagnostics")
        end,
        desc = "trouble doc diagnostics",
      },
      {
        "<leader>xq",
        function()
          require("trouble").toggle("quickfix")
        end,
        desc = "trouble quickfix",
      },
      {
        "<leader>xl",
        function()
          require("trouble").toggle("loclist")
        end,
        desc = "trouble loclist",
      },
      {
        "gR",
        function()
          require("trouble").toggle("lsp_references")
        end,
        desc = "trouble lsp references",
      },
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
      { "folke/lazydev.nvim", ft = "lua", opts = {} },
    },
    config = function()
      -- adding autocomplete capabilities...
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      -- capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if not client then
            return
          end

          if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end

          -- Mappings
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
        end,
      })

      for _, lsp in ipairs(servers) do
        require("lspconfig")[lsp].setup({
          -- on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      require("lspconfig")["lua_ls"].setup({
        -- on_attach = on_attach,
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
          -- on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      require("lspconfig")["pyright"].setup({
        -- on_attach = on_attach,
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

      ---@type lsp.ClientCapabilities
      local typ_cap = vim.deepcopy(capabilities)
      typ_cap.textDocument.completion.completionItem.snippetSupport = false
      require("lspconfig")["typst_lsp"].setup({
        -- on_attach = on_attach,
        capabilities = typ_cap,
      })

      -- require("lspconfig")["solargraph"].setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      -- })

      if vim.fn.getcwd() == vim.fn.expand("~/github/technical_writing") then
        require("lspconfig").ltex.setup({
          -- on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- null_ls.builtins.diagnostics.eslint,
          -- null_ls.builtins.code_actions.eslint,
          null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "javascriptreact", "typescriptreact" },
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.typstfmt,
          null_ls.builtins.formatting.nixfmt,
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
