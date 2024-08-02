local starter = require("mini.starter")

local function restore_session()
  require("persistence").load() -- Load session

  -- vim.cmd(":NvimTreeToggle") -- Open NvimTree
  vim.cmd(":NvimTreeFindFile") -- Open NvimTree
  vim.api.nvim_command("wincmd l") -- Move to right buffer
end

require("mini.starter").setup {
  -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
  -- started with intent to show something else.
  autoopen = true,

  -- Whether to evaluate action of single active item
  evaluate_single = false,

  -- Items to be displayed. Should be an array with the following elements:
  -- - Item: table with <action>, <name>, and <section> keys.
  -- - Function: should return one of these three categories.
  -- - Array: elements of these three types (i.e. item, array, function).
  -- If `nil` (default), default items will be used (see |mini.starter|).
  items = {
    { action = "Telescope find_files", name = "Find Files", section = "Telescope" },
    { action = "Telescope live_grep", name = "Seach Word", section = "Telescope" },
    -- { action = "Telescope oldfiles", name = "Recent Files", section = "Telescope" },
    { action = "TodoTelescope", name = "Todos", section = "Telescope" },

    starter.sections.recent_files(5, true),

    { action = "Telescope projects", name = "Projects", section = "Projects" },

    { action = restore_session, name = "Restore Session", section = "Session" },

    { action = "enew", name = "New Buffer", section = "Builtin actions" },
    { action = "qall!", name = "Quit Neovim", section = "Builtin actions" },
  },

  -- Header to be displayed before items. Converted to single string via
  -- `tostring` (use `\n` to display several lines). If function, it is
  -- evaluated first. If `nil` (default), polite greeting will be used.
  header = nil,

  -- Footer to be displayed after items. Converted to single string via
  -- `tostring` (use `\n` to display several lines). If function, it is
  -- evaluated first. If `nil` (default), default usage help will be shown.
  footer = nil,

  -- Array  of functions to be applied consecutively to initial content.
  -- Each function should take and return content for 'Starter' buffer (see
  -- |mini.starter| and |MiniStarter.content| for more details).
  content_hooks = nil,

  -- Characters to update query. Each character will have special buffer
  -- mapping overriding your global ones. Be careful to not add `:` as it
  -- allows you to go into command mode.
  query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

  -- Whether to disable showing non-error feedback
  silent = false,
}
