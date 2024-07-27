local function get_os_name()
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

local function get_username()
  return os.getenv "USER" or os.getenv "USERNAME"
end

local os_name = get_os_name()
local username = get_username()

local snippets_paths = {
  windows = "C:\\Users\\" .. username .. "\\AppData\\Local\\nvim\\lua\\snippets",
  linux = "/users/" .. username .. "/.config/nvim/lua/snippets",
  mac = "/Users/" .. username .. "/.config/nvim/lua/snippets",
  unknown = "~/.config/" .. username .. "/nvim/lua/snippets",
}

local snippet_path = snippets_paths[os_name]

require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").lazy_load {
  paths = snippet_path,
}
