-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.opt.fixendofline = true
vim.opt.endofline = true
vim.o.fixendofline = true
vim.o.endofline = true

-- 在配置中添加
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "a" } -- 禁用自动格式化
    vim.bo.formatexpr = nil
  end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Visual", {
      bg = "#ff9e64", -- 橙色背景，与图片中的边框色一致
      fg = "#1e1e2e", -- 深色文字，确保可读性
      bold = true,
    })
    -- 块选择模式 (Visual Block)
    vim.api.nvim_set_hl(0, "VisualNOS", {
      bg = "#f5a97f", -- 稍浅的橙色
      fg = "#1e1e2e",
    })

    -- 行选择模式 (Visual Line)
    vim.api.nvim_set_hl(0, "VisualLine", {
      bg = "#ff9e64",
      fg = "#1e1e2e",
      underline = true, -- 添加下划线增强可见性
    })

    -- 搜索高亮
    vim.api.nvim_set_hl(0, "IncSearch", {
      bg = "#f9e2af", -- 亮黄色
      fg = "#1e1e2e",
    })

    vim.api.nvim_set_hl(0, "Search", {
      bg = "#fab387", -- 橙黄色
      fg = "#1e1e2e",
    })
  end,
})
