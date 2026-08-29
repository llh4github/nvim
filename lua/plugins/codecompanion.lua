return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    prompts = {
      ["Explain"] = {
        strategy = "inline",
      },
    },
    adapters = {
      acp = {
        omp = {
          type = "custom",
          command = "omp",
          args = { "acp" },
        },
      },
    },
    interactions = {
      chat = {
        adapter = "omp",
      },
    },
  },
}
