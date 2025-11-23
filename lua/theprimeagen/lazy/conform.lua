return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },

                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },

                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },

                sh = { "shfmt" },
                go = { "gofmt" },
                python = { "black" },
            },
            formatters = {
                prettier = {
                    -- Use yarn to run prettier (works with Yarn PnP)
                    command = "yarn",
                    args = { "prettier", "--stdin-filepath", "$FILENAME" },
                },
            },
        })

        -- Keymap for manual formatting
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = false })
        end, { desc = "Format buffer or selection" })
    end
}

