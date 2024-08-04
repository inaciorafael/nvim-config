-- Adiciona o caminho do diretório acima ao package.path
package.path = package.path .. ';' .. vim.fn.expand('../?.lua')

local utils = require('utils')

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").lazy_load {
  paths = utils.get_nvim_path('/lua/snippets'),
}
