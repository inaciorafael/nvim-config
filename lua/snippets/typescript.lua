local ls = require "luasnip"
local snippet = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function capitalize(args)
  local word = args[1][1] or ""
  return word:sub(1, 1):upper() .. word:sub(2)
end

return {
  snippet(
    "us",
    fmt(
      [[
const [{}, set{}] = useState<{}>({});
    ]],
      {
        i(1, "state"),
        f(capitalize, { 1 }), -- transforma o placeholder
        i(2, "Type"),
        i(3, "default_value"),
      }
    )
  ),
}
