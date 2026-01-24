return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "texlab" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('lua_ls', {
                capabilities = capabilities
            })

            vim.lsp.config('pyright', {
                capabilities = capabilities
            })

            vim.lsp.config('texlab', {
                capabilities = capabilities,
                settings = {
                    texlab = {
                        build = {
                            executable = "latexmk",
                            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                            onSave = true,
                            forwardSearchAfter = true,
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = { "--synctex-editor-command", "nvr --remote-silent +%{line} %{input}", "%p" },
                        },
                        chktex = {
                            onOpenAndSave = true,
                        },
                        completion = {
                            disableSnippet = false,
                        },
                    },
                },
            })

            vim.lsp.enable({ 'lua_ls', 'pyright', 'texlab' })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
