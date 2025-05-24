-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.opt.fixendofline = true
vim.opt.endofline = true
vim.o.fixendofline = true
vim.o.endofline = true

-- 文件末尾添加空行
local function insert_newline()
    local last_line = vim.fn.getline('$')
    if last_line ~= "" then
        vim.fn.append(vim.fn.line('$'), "")
    end
end

-- 文件末尾添加空行
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = insert_newline,
})

-- 文件末尾添加空行
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = insert_newline,
})
-- 创建自动命令组（确保唯一性）
vim.api.nvim_create_augroup("AutoSaveOnExit", { clear = true })

-- 设置退出前自动保存
vim.api.nvim_create_autocmd("VimLeavePre", {
    group = "AutoSaveOnExit",
    pattern = "*",            -- 适用于所有文件
    callback = function()
        vim.cmd("silent! wa") -- 静默忽略错误
    end,
})
