local function ensure_leading_slash(path)
  if not path:match "^/" then
    return "/" .. path
  end
  return path
end

local M = {}

function M.get_username()
  return os.getenv "USER" or os.getenv "USERNAME"
end

function M.get_os_name()
  if vim.fn.has "mac" == 1 then
    return "mac"
  elseif vim.fn.has "unix" == 1 then
    return "linux"
  elseif vim.fn.has "win32" == 1 then
    return "windows"
  else
    return "unknown"
  end
end

function M.get_nvim_path(rest_path)
  local os_name = M.get_os_name()

  local nvim_paths = {
    windows = "~/AppData/Local/nvim",
    linux = "~/.config/nvim",
    mac = "~/.config/nvim",
    unknown = "~/.config/nvim",
  }

  return vim.fn.expand(nvim_paths[os_name] .. ensure_leading_slash(rest_path))
end

function M.capitalize(nome)
  return nome:sub(1, 1):upper() .. nome:sub(2)
end

function M.substituir_placeholders(conteudo, placeholders)
  for chave, valor in pairs(placeholders) do
    conteudo = conteudo:gsub("{{" .. M.capitalize(chave) .. "}}", M.capitalize(valor))
    conteudo = conteudo:gsub("{{" .. chave .. "}}", valor)
  end

  return conteudo
end

function M.carregar_template(caminho_template, nome)
  local file = io.open(caminho_template, "r")

  if not file then
    return nil
  end

  local conteudo = file:read("*a")
  file:close()

  return conteudo:gsub("{{name}}", nome)
end

return M
