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

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
        local last_line = vim.fn.getline('$')
        if last_line ~= "" then
            vim.fn.append(vim.fn.line('$'), "")
        end
    end
})
