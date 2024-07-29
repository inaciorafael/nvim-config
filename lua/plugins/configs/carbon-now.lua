-- FIXME: Remover plugin e adicionar função pura para criar screenshot do código usando Carbon.sh

require("carbon-now").setup {
  base_url = "https://carbon.now.sh/",
  options = {
    bg = "rgb(74, 144, 226)",
    drop_shadow_blur = "68px",
    l = "auto",
    drop_shadow = false,
    drop_shadow_offset_y = "20px",
    font_family = "Fira Code",
    font_size = "18px",
    line_height = "133%",
    line_numbers = true,
    theme = "nord",
    titlebar = vim.api.nvim_buf_get_name(0),
    watermark = false,
    wa = true,
    width = "680",
    window_theme = "bw",
    padding_horizontal = "30px",
    padding_vertical = "30px",
  },
}
