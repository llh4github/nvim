-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.options")
require("config.lazy")


-- 设置高亮组
vim.api.nvim_set_hl(0, "Visual", { bg = "#475569" })
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#00274D", fg = "#ADD8E6", bold = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 2333 })
	end,
})
