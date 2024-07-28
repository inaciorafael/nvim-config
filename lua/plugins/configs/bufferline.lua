-- FIXME: Ao fechar uma tab o buffer de edição principal fecha também.

require("bufferline").setup {
  options = {
    themable = true,
    offsets = {
      { filetype = "NvimTree", highlight = "NvimTreeNormal" },
    },
  },
}
