-- bootstrap lazy.nvim, LazyVim and your plugins
-- 检测是否为 Windows 系统
local is_windows = package.config:sub(1, 1) == '\\' or os.getenv('OS') == 'Windows_NT'
if is_windows then
    vim.o.shell = "pwsh.exe"
    vim.o.shellcmdflag = "-NoLogo -NoProfile -Command Set-Location -LiteralPath '%s'"
end
require("config.lazy")

-- GUI 配置，后面把它移到单独的文件中
if vim.g.neovide then
    vim.g.neovide_title_background_color = string.format(
        "%x",
        vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg
    )

    vim.g.neovide_title_text_color = "pink"
    vim.g.neovide_remember_window_size = true
end
