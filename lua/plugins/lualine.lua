return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "meuter/lualine-so-fancy.nvim",
  },
  opts = {
    extensions = { "neo-tree", "toggleterm" },
    options = {
      theme = "auto",
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
    },
    sections = {
      lualine_a = {
        { "mode" },
      },
      lualine_b = {
        { "branch" },
        { "fancy_diff" },
      },
      lualine_c = {
        { "filename", substitute_home = true },
      },
      lualine_x = {
        { "fancy_macro" },
        { "fancy_diagnostics" },
        { "fancy_searchcount" },
        { "fancy_location" },
      },
      lualine_y = {
        { "filetype", ts_icon = "" },
      },
      lualine_z = {
        { "fancy_lsp_servers" },
      },
    },
  },
}
