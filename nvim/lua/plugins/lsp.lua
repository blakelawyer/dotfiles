-- No mason. Every tool except basedpyright is in Arch extra:
--   pacman -S lua-language-server bash-language-server ruff shfmt shellcheck stylua
--   uv tool install basedpyright
--
-- nvim-lspconfig ships lsp/*.lua runtime files that vim.lsp.config()/enable()
-- resolve directly, so it is used purely as a config database.

return {
    "neovim/nvim-lspconfig",
    -- Must be on the rtp before vim.lsp.enable() runs, so it cannot lazy-load
    -- behind an event that fires later than this config function.
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    -- arrayIndex off: it annotates every element of every table
                    -- literal, which buries the hints that actually say something.
                    hint = { enable = true, arrayIndex = "Disable", setType = true },
                },
            },
        })

        vim.lsp.config("basedpyright", {
            settings = {
                basedpyright = {
                    -- ruff owns import organisation
                    disableOrganizeImports = true,
                    analysis = {
                        typeCheckingMode = "standard",
                        diagnosticMode = "openFilesOnly",
                        inlayHints = {
                            callArgumentNames = true,
                            functionReturnTypes = true,
                            variableTypes = true,
                            -- noisy in generic-heavy code, and this codebase has plenty
                            genericTypes = false,
                        },
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            -- basedpyright owns hover; ruff owns lint, fix and imports
            on_attach = function(client) client.server_capabilities.hoverProvider = false end,
        })

        vim.lsp.config("bashls", {
            settings = {
                -- bashls shells out to shellcheck automatically when it's on PATH
                bashIde = { globPattern = "*@(.sh|.inc|.bash|.command)" },
            },
        })

        ---------------------------- ~/code/work ----------------------------
        -- vue_ls runs in hybrid mode: it owns only the CSS/HTML sections of a
        -- .vue file and forwards everything else to ts_ls, which needs
        -- @vue/typescript-plugin loaded to understand them. Resolved at runtime
        -- rather than hardcoded, since the path differs between the Arch package
        -- and an npm -g install.
        local function vue_plugin_location()
            for _, root in ipairs({
                "/usr/lib/node_modules/@vue/language-server",
                vim.fn.expand("~/.local/share/npm/lib/node_modules/@vue/language-server"),
                "/usr/local/lib/node_modules/@vue/language-server",
            }) do
                if vim.uv.fs_stat(root) then
                    return root
                end
            end
        end

        local ts_init = {}
        local vue_location = vue_plugin_location()
        if vue_location then
            ts_init.plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vue_location,
                    languages = { "vue" },
                },
            }
        end

        -- ts_ls keys inlay hints off the language, not the server, so the same
        -- block has to be registered twice.
        local ts_inlay_hints = {
            includeInlayParameterNameHints = "literal",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        }

        vim.lsp.config("ts_ls", {
            init_options = ts_init,
            settings = {
                typescript = { inlayHints = ts_inlay_hints },
                javascript = { inlayHints = ts_inlay_hints },
            },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue",
            },
        })

        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    analyses = { unusedparams = true, unusedwrite = true },
                    staticcheck = true,
                    gofumpt = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                    codelenses = { generate = true, test = true, tidy = true, upgrade_dependency = true },
                },
            },
        })

        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    keyOrdering = false,
                    schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
                },
            },
        })

        vim.lsp.config("clangd", {
            -- without a compile_commands.json clangd guesses; this keeps the
            -- guesses sane for the kernel/bsp trees
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--fallback-style=llvm",
            },
        })

        vim.lsp.enable({
            "lua_ls",
            "basedpyright",
            "ruff",
            "bashls",
            "ts_ls",
            "vue_ls",
            "gopls",
            "yamlls",
            "jsonls",
            "clangd",
        })

        -- Both default to off, so the servers' hint/codelens settings above
        -- render nothing until this runs.
        --
        -- No LspAttach hook and no vim.lsp.codelens.refresh() loop: as of 0.12
        -- these are "capabilities" (see lsp/_capability.lua). A global enable
        -- sets a marker that vim.lsp.client re-checks on every attach, and it
        -- guards on supports_method itself -- so servers that don't offer the
        -- method are skipped, and buffers opened later are picked up for free.
        -- The old refresh({ bufnr }) form is deprecated for removal in 0.13.
        vim.lsp.inlay_hint.enable(true)
        vim.lsp.codelens.enable(true)

        vim.diagnostic.config({
            severity_sort = true,
            underline = true,
            update_in_insert = false,
            virtual_text = { spacing = 2, prefix = "●", source = "if_many" },
            float = { border = "rounded", source = "if_many" },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN] = "W",
                    [vim.diagnostic.severity.INFO] = "I",
                    [vim.diagnostic.severity.HINT] = "H",
                },
            },
        })

        -- Opening a file should not editorialise about it. The servers still run
        -- and still publish -- this only switches off the display handlers, so
        -- completion, hover, goto, rename, inlay hints and codelens are unaffected
        -- and the config above is what you get the moment you turn them back on.
        --
        -- vim.diagnostic.get() is deliberately not gated by this, so <leader>e
        -- still floats the current line's diagnostics on demand, and <leader>ud
        -- flips everything back on for the session.
        vim.diagnostic.enable(false)
    end,
}
