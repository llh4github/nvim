-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- 自定义快捷键映射 ---
map("n", "<a-1>", function()
  require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
end, { desc = "Explorer NeoTree (Root Dir)" })

map("n", "<leader>xc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- 自定义快捷键映射 end ---

-- 删除快捷键 ---
unmap("n", "<leader>l", { desc = "Lazy" })
unmap("n", "<c-/>", { desc = "terminal" })
unmap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
unmap("n", "<leader>fe", { desc = "Explorer NeoTree (Root Dir)" })
-- 去掉 <leader><leader> 来搜索文件的映射
unmap("n", "<leader><space>", { desc = "Find Files (root dir)" })
-- 删除快捷键 end ---
