-- lsp.lua - CONFIGURAÇÃO LIMPA E FUNCIONAL

print "🚀 Iniciando configuração LSP..."

-- ============================================
-- CARREGAMENTO DO MASON (uma vez só)
-- ============================================
local ok, mason = pcall(require, "mason")
if not ok then
  print "❌ Mason não disponível"
  return
end
print "✅ Mason require ok"

mason.setup()
print "✅ Mason setup ok"

local registry_ok, registry = pcall(require, "mason-registry")
if not registry_ok then
  print "❌ Registry não disponível"
  return
end
print "✅ Registry require ok"

-- ============================================
-- CAMINHO DO VUE LANGUAGE SERVER
-- ============================================
-- ============================================
-- CAMINHO DO VUE LANGUAGE SERVER (VERSÃO ALTERNATIVA)
-- ============================================
local vue_pkg = registry.get_package("vue-language-server")
if not vue_pkg then
  print("❌ Pacote vue-language-server não encontrado no registry")
  return
end

-- Tenta diferentes formas de pegar o caminho
local vue_install_path = nil
local path_ok, path_result = pcall(function()
  -- Tenta como método
  if vue_pkg.get_install_path then
    return vue_pkg:get_install_path()
  -- Tenta como campo
  elseif vue_pkg.install_path then
    return vue_pkg.install_path
  -- Tenta como propriedade
  elseif vue_pkg.path then
    return vue_pkg.path
  else
    error("Não foi possível encontrar o caminho de instalação")
  end
end)

if not path_ok then
  print("❌ Erro ao obter caminho: " .. tostring(path_result))
  print("👉 Usando caminho padrão do Mason...")
  vue_install_path = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server'
else
  vue_install_path = path_result
end

-- Verifica se o caminho existe
if vim.fn.isdirectory(vue_install_path) == 0 then
  print("❌ Diretório não encontrado: " .. vue_install_path)
  return
end

local vue_language_server_path = vue_install_path .. "/node_modules/@vue/language-server"
print("✅ Vue LSP encontrado em: " .. vue_language_server_path)

-- ============================================
-- CONFIGURAÇÃO DOS SERVIDORES
-- ============================================
local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_makers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
      },
    },
  },

  tailwindcss = {
    filetypes = { "typescriptreact", "javascriptreact", "html", "vue" },
  },

  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
    filetypes = { "javascript", "typescript", "vue", "typescriptreact", "javascriptreact" },
  },

  vue_ls = {
    filetypes = { "vue" },
  },

  eslint = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
    root_markers = { ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "package.json" },
    settings = {
      workingDirectory = { mode = "location" },
      validate = "on",
      run = "onType",
      codeAction = { enable = true },
    },
  },

  rust_analyzer = {
    cmd = { "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = { command = "clippy" },
        cargo = { allFeatures = true },
      },
    },
  },
}

-- ATIVA OS SERVIDORES
for name, config in pairs(servers) do
  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end
print "✅ Servidores LSP configurados"

-- ============================================
-- KEYMAPS
-- ============================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  end,
})

print "🎉 Configuração LSP finalizada!"
