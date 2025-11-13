local utils = require("lsp.utils")

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  on_attach = utils.on_attach,
  capabilities = utils.capabilities,
}
