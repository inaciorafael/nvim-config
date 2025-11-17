require("nvim-treesitter.configs").setup {
  ensure_installed = { "typescript", "tsx", "python", "css", "html" },
  highlight = {
    enable = true,
    use_languagetree = true,
    -- additional_vim_regex_highlighting = false, -- PERFORMANCE: melhora performance
  },
  indent = { enable = true },
}
