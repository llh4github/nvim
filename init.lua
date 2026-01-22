-- bootstrap lazy.nvim, LazyVim and your plugins

require("config.lazy")

-- GUI 配置，后面把它移到单独的文件中
if vim.g.neovide then
  vim.g.neovide_title_background_color =
      string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)
  vim.o.guifont = "JetBrainsMono Nerd Font:h16"
  vim.g.neovide_title_text_color = "pink"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
