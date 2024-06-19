-- jump to the first definition automatically if the multiple defs are on the same line
-- otherwise show a telescope selector
-- from https://github.com/seblj/dotfiles/blob/014fd736413945c888d7258b298a37c93d5e97da/nvim/lua/config/lspconfig/handlers.lua
vim.lsp.handlers["textDocument/definition"] = function(_, result, ctx)
  if not result or vim.tbl_isempty(result) then
    vim.notify("[lsp]: Could not find definition", vim.log.levels.INFO)
    return
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then return end

  if vim.islist(result) then
    local results = vim.lsp.util.locations_to_items(result, client.offset_encoding)
    local lnum, filename = results[1].lnum, results[1].filename
    for _, val in pairs(results) do
      if val.lnum ~= lnum or val.filename ~= filename then
        return require("telescope.builtin").lsp_definitions()
      end
    end
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding, false)
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding, false)
  end
end

vim.lsp.handlers["textDocument/references"] = function(_, _, _)
  require("telescope.builtin").lsp_references()
end

-- filter out diagnostics that complain about unused variable names if those variable names start
-- with an underscore. Rust does it right.
-- idea from: https://www.reddit.com/r/neovim/comments/108tjy0/nvimlspconfig_how_to_disable_hints_for_unused/
-- code is /very/ heavily modified
local function custom_on_publish_diagnostics(a, params, client_id, c)
  params.diagnostics = vim
    .iter(params.diagnostics)
    :filter(function(diag)
      --                 lua                    pyright
      local patterns = { "Unused local `_.+`.", '"_.+" is not accessed' }
      return not vim.iter(patterns):any(function(pat) return string.match(diag.message, pat) end)
    end)
    :totable()
  vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})
