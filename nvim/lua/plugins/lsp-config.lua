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
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                capabilities = capabilities
            })
            lspconfig.texlab.setup({
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
                    disableSnippet = false,  -- Enable snippet support if desired
                  },
                },
              },
            })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
