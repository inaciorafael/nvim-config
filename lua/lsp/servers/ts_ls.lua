local utils = require("lsp.utils")

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  on_attach = utils.on_attach,
  capabilities = utils.capabilities,
}
