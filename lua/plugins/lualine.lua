return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- 去掉时间显示
    opts.sections.lualine_z = {}

    -- 在右下角添加文件换行符和编码
    opts.sections.lualine_y = {
      { "fileformat", symbols = { unix = " LF", dos = " CRLF", mac = " CR" } },
      { "encoding" },
    }

    -- 右下角显示光标所在行列位置（替代默认时间显示）
    opts.sections.lualine_z = {
      { "location", padding = { left = 1, right = 1 } },
    }

    -- 不使用 > < 作为分隔符，仅用空格分隔各段
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "", right = "" }
  end,
}
