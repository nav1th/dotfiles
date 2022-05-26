local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "nav1th.lsp.configs"
require("nav1th.lsp.handlers").setup()
require "nav1th.lsp.null-ls"
