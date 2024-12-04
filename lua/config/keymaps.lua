-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

--#region del key map
unmap("n", "<leader>fT", { desc = "Terminal (cwd)" })
unmap("n", "<leader>ft", { desc = "Terminal (Root Dir)" })
unmap("n", "<c-/>", { desc = "Terminal (Root Dir)" })
--#endregion
--#region common mappings
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save All Modified File" })
map({ "i" }, "<C-a>", "<Esc>ggVG", { noremap = true, desc = "全选" })
--#endregion
--#region floating terminal
map("n", "<M-F12>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("t", "<M-F12>", "<cmd>close<cr>", { desc = "Hide Terminal" })
--#endregion
