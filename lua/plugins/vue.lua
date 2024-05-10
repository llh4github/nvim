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
    "nvim-lspconfig",
    -- opts = {
    --   setup = {
    --     volar = function()
    --       require("lazyvim.util").lsp.on_attach(function(client, _)
    --         if client.name == "volar" then
    --           client.server_capabilities.documentFormattingProvider = false
    --         end
    --       end)
    --     end,
    --   },
    -- },
    opts = function(_, opts)
      local mason_registry = require("mason-registry")
      local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"

      opts.servers.volar = {
        filetypes = {
          "vue",
        },
      }

      opts.servers.tsserver = {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "javascript", "typescript", "vue" },
              -- configNamespace = "typescript",
              -- enableForWorkspaceTypeScriptVersions = true,
            },
          },
        },
        filetypes = {
          -- "typescript",
          -- "javascript",
          "javascriptreact",
          "typescriptreact",
          "vue",
        },
      }

      return opts
    end,
  },
  {
    "catgoose/vue-goto-definition.nvim",
    event = "BufReadPre",
    opts = {
      filters = {
        auto_imports = true,
        auto_components = true,
        import_same_file = true,
        declaration = true,
        duplicate_filename = true,
      },
      filetypes = { "vue", "typescript" },
      detection = {
        nuxt = function()
          return vim.fn.glob(".nuxt/") ~= ""
        end,
        vue3 = function()
          return vim.fn.filereadable("vite.config.ts") == 1 or vim.fn.filereadable("src/App.vue") == 1
        end,
        priority = { "nuxt", "vue3" },
      },
      lsp = {
        override_definition = true, -- override vim.lsp.buf.definition
      },
      debounce = 200,
    },
  },
}
