require('telescope').load_extension('projects')
-- require("telescope").load_extension("undo")

require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = { prompt_position = "top" },
    },
  },
}
