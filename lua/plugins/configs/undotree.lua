local utils = require('./utils')

vim.g.undotree_WindowLayout = 1 -- Exemplo: define o layout da janela do Undotree
vim.g.undotree_SplitWidth = 28 -- Exemplo: define o layout da janela do Undotree

if utils.get_os_name() == "windows" then
  vim.g.undotree_DiffCommand = utils.get_nvim_path('/bin/diff.exe')
end
