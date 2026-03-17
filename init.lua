require "commands"
require "mappings"
require "options"
-- require "lsp"

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require "plugins"

-- Espera 1 segundo e DEPOIS carrega o LSP
vim.defer_fn(function()
  require('lsp')
end, 1000) -- 1000ms = 1 segundo

vim.cmd.colorscheme "everforest"

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- TODO: Funcionalidades para criar:
-- Explicador de código com I.A: Selecionar o bloco de código e a i.a explica o que o código faz e sugere melhorias
--  Projectscan: Escaneia projeto e captura informações importantes, quantidade de dependencias, dependencias não utilizadas no projeto, apis, componentes, providers, contexts, hooks etc.
-- Colar TS: Ao copiar um json converter o mesmo automaticamente para typescript
