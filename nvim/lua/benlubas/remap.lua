local nnoremap = require("benlubas.keymap").nnoremap

nnoremap("<leader>e", "<cmd>w<CR><cmd>Ex<CR>")

-- TELESCOPE BINDS
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")

-- LSP BINDS 
nnoremap("K",     "<cmd>lua vim.lsp.buf.hover()<CR>")
nnoremap("gD",    "<cmd>lua vim.lsp.buf.implementation()<CR>")
nnoremap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
nnoremap("1gD",   "<cmd>lua vim.lsp.buf.type_definition()<CR>")
nnoremap("gr",    "<cmd>lua vim.lsp.buf.references()<CR>")
nnoremap("g0",    "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
nnoremap("gW",    "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
nnoremap("gd",    "<cmd>lua vim.lsp.buf.definition()<CR>")


-- Neo Git
nnoremap("<leader>gi", "<cmd>Neogit<CR>")
