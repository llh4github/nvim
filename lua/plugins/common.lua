return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "typescript-language-server",
        "vue-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "scss",
        "regex",
        "vue",
        "rust",
        "go",
        "java",
        "xml",
      })
    end,
  },
  { "folke/neoconf.nvim" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("neo-tree").setup({
        follow_current_file = {
          enabled = false, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        filesystem = {
          group_empty_dirs = true,
        },
      })
    end,
  },
}
