-- nvim-treesitter `main` branch (the 2026 rewrite). The repo was archived in
-- April 2026 and subsequently un-archived; it is actively maintained again.
--
-- Neovim 0.12 bundles parsers for only c, lua, markdown, markdown_inline, query,
-- vim and vimdoc, and has no parser installer in core. Everything in ~/code/work
-- -- javascript, python, vue, bash, sql, yaml, go -- needs a parser from here.
-- (syntax/vue.vim is a 14-line stub, so Vue has effectively no legacy fallback.)
--
-- Unlike the old master branch, `main` does not enable highlighting for you:
-- vim.treesitter.start() has to be called per buffer.

local ensure = {
    -- editing this config
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "query",
    -- prose
    "markdown",
    "markdown_inline",
    -- ~/code/work, by file count
    "javascript",
    "jsdoc",
    "python",
    "vue",
    "bash",
    "sql",
    "yaml",
    "go",
    "gomod",
    "gosum",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "php",
    "html",
    "css",
    -- config / plumbing
    "json", -- also handles jsonc; there is no separate jsonc parser
    "toml",
    "dockerfile",
    "make",
    "diff",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "regex",
    "xml",
    "ssh_config",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- upstream states this plugin does not support lazy-loading
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(ensure)

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("cfg_treesitter", { clear = true }),
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                if not lang then
                    return
                end
                -- errors when no parser is installed for the language, which is
                -- the normal case for anything outside `ensure`
                if not pcall(vim.treesitter.start, ev.buf, lang) then
                    return
                end
                -- upstream still marks treesitter indentation experimental, so
                -- leave any filetype that ships a real indentexpr alone
                if vim.bo[ev.buf].indentexpr == "" then
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
                -- [0][0] scopes these to this buffer within the current window,
                -- so they don't leak to other buffers shown in the same window
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"
            end,
        })
    end,
}
