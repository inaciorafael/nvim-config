require("highlight-undo").setup {
  hlgroup = "HighlightUndo",
  duration = 300,
  pattern = { "*" },
  ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
}
