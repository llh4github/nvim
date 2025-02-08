return {
  {
    "folke/tokyonight.nvim",
    cond = (function() return not vim.g.vscode end),
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end
  },
}
