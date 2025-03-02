local M = {}
local utils = require "./utils"

function M.switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand "<cword>"
  local word_start = vim.fn.matchstrpos(vim.fn.getline ".", "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

  -- Detect camelCase
  if word:find "[a-z][A-Z]" then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
  -- Detect snake_case
  elseif word:find "_[a-z]" then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub("(_)([a-z])", function(_, l)
      return l:upper()
    end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    print "Not a snake_case or camelCase word"
  end
end

local function criar_componente(nome, type)
  if not nome or nome == "" then
    print "Erro: Nome do componente não fornecido."
    return
  end

  local nvim_tree = require "nvim-tree.api"
  local node = nvim_tree.tree.get_node_under_cursor()
  local diretorio_atual = node and node.absolute_path or vim.fn.getcwd()

  local pasta_componente = diretorio_atual .. "/" .. nome
  vim.fn.mkdir(pasta_componente, "p")

  local templates

  if type == "component" then
    templates = {
      { caminho_template = utils.get_nvim_path "/templates/rgc/component.tsx", extensao = ".component.tsx" },
      { caminho_template = utils.get_nvim_path "/templates/rgc/model.ts", extensao = ".model.ts" },
      { caminho_template = utils.get_nvim_path "/templates/rgc/styles.css", extensao = ".styles.css" },
      { caminho_template = utils.get_nvim_path "/templates/rgc/index.ts", extensao = "/index.ts" },
    }
  end

  if type == 'page' then
    templates = {
      { caminho_template = utils.get_nvim_path "/templates/rgp/view.tsx", extensao = ".view.tsx" },
      { caminho_template = utils.get_nvim_path "/templates/rgp/types.ts", extensao = ".types.ts" },
      { caminho_template = utils.get_nvim_path "/templates/rgp/model.ts", extensao = ".model.ts" },
      { caminho_template = utils.get_nvim_path "/templates/rgp/styles.css", extensao = ".styles.css" },
      { caminho_template = utils.get_nvim_path "/templates/rgp/index.ts", extensao = "/index.ts" },
    }
  end

  for _, template in ipairs(templates) do
    local conteudo = utils.carregar_template(template.caminho_template, nome)
    conteudo = utils.substituir_placeholders(conteudo, { name = nome })

    if not conteudo then
      print("Erro ao carregar o template: " .. template.caminho_template)
      return
    end

    -- Define o caminho do arquivo
    local caminho_arquivo
    if template.extensao == "/index.ts" then
      caminho_arquivo = pasta_componente .. template.extensao
    else
      caminho_arquivo = pasta_componente .. "/" .. nome .. template.extensao
    end

    -- Cria o arquivo e escreve o conteúdo
    local file = io.open(caminho_arquivo, "w")
    if file then
      file:write(conteudo)
      file:close()
    else
      print("Erro ao criar o arquivo: " .. caminho_arquivo)
    end
  end

  print("Arquivos do componente criados em " .. pasta_componente)
end

vim.api.nvim_create_user_command("Rgc", function(opts)
  criar_componente(opts.args, 'component')
end, { nargs = 1 })

vim.api.nvim_create_user_command("Rgp", function(opts)
  criar_componente(opts.args, 'page')
end, { nargs = 1 })

return M
