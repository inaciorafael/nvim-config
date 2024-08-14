require("rayso").setup {
  open_cmd = "brave",
  options = {
    logging_path = "/Users/rafae/Documents/Rayso/", -- Notices the trailing slash
    logging_file = "rayso",
    logging_enabled = true,
    theme = "midnight",
    padding = 16,
  },
}

-- Rayso
vim.keymap.set("v", "<leader>ss", require("lib.create").create_snippet)
