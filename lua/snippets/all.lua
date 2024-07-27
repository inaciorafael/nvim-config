local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

return {
  s("trigger", {
    t { "After jumping forward once, cursor is here ->" },
    i(2),
    t { "", "After expanding, the cursor is here ->" },
    i(1),
    t { "", "After jumping once more, the snippet is exited there ->" },
    i(0),
  }),
}
