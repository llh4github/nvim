return {
  {
    --"neovim/nvim-lspconfig",
    "stevearc/conform.nvim",
    opts = {
      async = true,
      default_format_opts = {
        timeout_ms = 3000,
      },
      formatters_by_ft = {
        ["*"] = { "trim_whitespace" }, -- 在所有文件类型最后执行
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
      },
    },
  },
}
