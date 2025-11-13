local M = {}

-- Capabilities globais (por exemplo, suporte a autocomplete)
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Função comum para rodar quando o servidor anexa ao buffer
M.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }
  local map = vim.keymap.set

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "<leader>cr", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)

  -- Desabilitar formatação se quiser usar outro formatador
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

return M
