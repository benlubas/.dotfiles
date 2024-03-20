require("benlubas.set")
require("benlubas.remap")
require("benlubas.autocommands")
require("benlubas.filetype")
require("benlubas.lsp_handlers")
require("benlubas.messages")
require("benlubas.gh_stalk")

pcall(require, "benlubas.work")

if MarkdownMode() then
  require("benlubas.firenvim")
end
