local M = {}

-- Carrega configs básicas
local utils = require "lsp.utils"

-- LSPs disponíveis (basta criar um novo arquivo e adicionar aqui)
local servers = {
  lua_ls = require "lsp.servers.lua_ls",
  ts_ls = require "lsp.servers.ts_ls",
  pyright = require "lsp.servers.pyright",
}

-- Configuração global
vim.lsp.config["*"] = {
  capabilities = utils.capabilities,
  on_attach = utils.on_attach,
}

-- Registra servidores individualmente
for name, config in pairs(servers) do
  vim.lsp.config[name] = config
end

-- Inicializa automaticamente o LSP com base no filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python", "typescript", "javascript", "typescriptreact", "javascriptreact" },
  callback = function()
    local ft = vim.bo.filetype
    local server_name

    if ft == "lua" then
      server_name = "lua_ls"
    elseif ft == "python" then
      server_name = "pyright"
    else
      server_name = "ts_ls"
    end

    local cfg = vim.lsp.config[server_name]
    if cfg then
      vim.lsp.start(cfg)
    end
  end,
})

return M
