require("benlubas.globals")
require("benlubas.set")
require("benlubas.remap")
require("benlubas.autocommands")
require("benlubas.filetype")
require("benlubas.lsp_handlers")
require("benlubas.messages")

pcall(require, "benlubas.work")

if MarkdownMode() then
  require("benlubas.firenvim")
end
