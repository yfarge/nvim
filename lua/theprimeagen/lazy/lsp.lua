return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
        "stevearc/conform.nvim",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
    },

    config = function()
        ---------------------------------------------------------------------
        -- Conform: Formatting -----------------------------------------------
        ---------------------------------------------------------------------
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

            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 5000,
            },
        })

        -- Keymap for manual formatting
        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, { desc = "Format buffer or selection" })

        ---------------------------------------------------------------------
        -- LSP Capabilities --------------------------------------------------
        ---------------------------------------------------------------------
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        ---------------------------------------------------------------------
        -- Mason & Fidget ---------------------------------------------------
        ---------------------------------------------------------------------
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "gopls" },
            handlers = {
                -- Default handler
                function(server_name)
                    require("lspconfig")[server_name].setup({ capabilities = capabilities })
                end,

                -- Lua LSP customization
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = { checkThirdParty = false },
                                format = {
                                    enable = true,
                                    defaultConfig = { indent_style = "space", indent_size = "2" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        ---------------------------------------------------------------------
        -- nvim-cmp: Completion ---------------------------------------------
        ---------------------------------------------------------------------
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })

        ---------------------------------------------------------------------
        -- Diagnostics -------------------------------------------------------
        ---------------------------------------------------------------------
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
