-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- 启用相对行号
vim.o.relativenumber = true

-- 同时显示绝对行号
vim.o.number = true
-- 设置默认使用系统剪贴板
vim.opt.clipboard = "unnamedplus"
-- vim.g.autoformat = false
