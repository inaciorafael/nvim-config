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

return M
