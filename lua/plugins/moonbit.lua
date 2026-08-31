return {
  "moonbit-community/moonbit.nvim",
  ft = { "moonbit" },
  opts = {
    mooncakes = {
      virtual_text = true,
      use_local = true,
    },
    treesitter = {
      enabled = true,
      auto_install = true,
    },
    lsp = {
      native = true,
      on_attach = function(client, bufnr) end,
      capabilities = vim.lsp.protocol.make_client_capabilities(),
    },
    jsonls = {
      settings = {},
    },
  },
}
