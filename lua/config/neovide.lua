-- Neovide GUI 配置
-- https://neovide.dev/configuration.html

local M = {}

function M.setup()
  if not vim.g.neovide then
    return
  end

  -- 窗口与标题
  vim.g.neovide_title_text_color = "pink"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_remember_window_position = true

  -- 标题背景跟随 Normal 背景；init.lua 执行时 colorscheme 可能还没加载，bg 会是 nil
  vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
    group = vim.api.nvim_create_augroup("NeovideConfig", { clear = true }),
    callback = function()
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal" })
      if ok and hl and hl.bg then
        vim.g.neovide_title_background_color = string.format("%x", hl.bg)
      end
    end,
  })

  -- 字体（家族名取本机注册表中的实际名字）
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h16"

  -- 光标
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_opacity = 200

  -- 输入与交互
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_no_idle = true

  -- IME：仅在插入模式和 / ? 搜索时启用，普通模式/普通命令行保持关闭，
  -- 避免导航时误切中文输入法
  local function set_ime(args)
    vim.g.neovide_input_ime = args.event:match("Enter$") ~= nil
  end

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("NeovideIme", { clear = true }),
    pattern = "*",
    callback = set_ime,
  })
  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = "NeovideIme",
    pattern = "[\\/\\?]",
    callback = set_ime,
  })
end

return M
