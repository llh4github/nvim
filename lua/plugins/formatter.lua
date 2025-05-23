return {
    {
        --"neovim/nvim-lspconfig",
        "stevearc/conform.nvim",
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                -- 文末添加空行
                callback = function(err, did_edit)
                    if did_edit then
                        local last_line = vim.fn.getline('$')
                        if last_line ~= "" then
                            vim.fn.append(vim.fn.line('$'), "")
                        end
                    end
                end
            },
            formatters_by_ft = {
                ["*"] = { "trim_whitespace" }, -- 在所有文件类型最后执行
                go = { "gofmt", "goimports" },
            },

        },
    },
}
