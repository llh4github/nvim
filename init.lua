-- bootstrap lazy.nvim, LazyVim and your plugins
-- 检测是否为 Windows 系统
local is_windows = package.config:sub(1, 1) == '\\' or os.getenv('OS') == 'Windows_NT'
if is_windows then
    vim.o.shell = "pwsh.exe"
    vim.o.shellcmdflag = "-NoLogo -NoProfile -Command Set-Location -LiteralPath '%s'"
end
require("config.lazy")
