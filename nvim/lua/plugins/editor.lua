return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            ts_config = { lua = { "string" } },
            disable_filetype = { "snacks_picker_input", "snacks_input" },
        },
        -- no cmp integration needed; blink handles brackets via
        -- completion.accept.auto_brackets
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        -- Not three plain `vim.keymap.set('i', 'jk', '<Esc>')` calls: those make
        -- both j and k ambiguous prefixes, so every j and k typed stalls for
        -- timeoutlen before rendering. better-escape maps only the second key.
        opts = {
            timeout = 250,
            default_mappings = false,
            mappings = {
                i = {
                    j = { k = "<Esc>", j = "<Esc>" },
                    k = { j = "<Esc>" },
                },
                c = {
                    j = { k = "<C-c>", j = "<C-c>" },
                    k = { j = "<C-c>" },
                },
                t = { j = { k = "<C-\\><C-n>" } },
                v = { j = { k = "<Esc>" } },
            },
        },
    },
    {
        -- 0.12 ships `gc` commenting natively, but nothing for surrounds.
        -- Defaults are the vim-surround set: ys/yss/yS, ds, cs/cS, visual S.
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        -- 0.12's native `an`/`in` walk the syntax tree generically (parent/child
        -- node). These are the named objects -- "inside this function", "around
        -- this class" -- which generic node traversal can't express.
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = { ["@function.outer"] = "V", ["@class.outer"] = "V" },
                },
                move = { set_jumps = true },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            -- Not touching vim.g.no_plugin_maps, which the README suggests: it
            -- kills every built-in ftplugin mapping, not just the ]m/[m ones
            -- that would collide. Picking non-colliding keys is cheaper.
            local objects = {
                f = { query = "@function.outer", inner = "@function.inner", desc = "function" },
                c = { query = "@class.outer", inner = "@class.inner", desc = "class" },
                a = { query = "@parameter.outer", inner = "@parameter.inner", desc = "parameter" },
                o = { query = "@loop.outer", inner = "@loop.inner", desc = "loop" },
                i = { query = "@conditional.outer", inner = "@conditional.inner", desc = "conditional" },
            }
            for key, obj in pairs(objects) do
                vim.keymap.set(
                    { "x", "o" },
                    "a" .. key,
                    function() select.select_textobject(obj.query, "textobjects") end,
                    { desc = "Around " .. obj.desc }
                )
                vim.keymap.set(
                    { "x", "o" },
                    "i" .. key,
                    function() select.select_textobject(obj.inner, "textobjects") end,
                    { desc = "Inside " .. obj.desc }
                )
            end

            -- ]f/[f shadow the vi-compat synonyms for `gf`; gf itself is untouched.
            -- Deliberately not ]m/[m (python/go ftplugins own those) or ]c/[c
            -- (vim's diff-mode change motions).
            vim.keymap.set(
                { "n", "x", "o" },
                "]f",
                function() move.goto_next_start("@function.outer", "textobjects") end,
                { desc = "Next function start" }
            )
            vim.keymap.set(
                { "n", "x", "o" },
                "[f",
                function() move.goto_previous_start("@function.outer", "textobjects") end,
                { desc = "Prev function start" }
            )
            vim.keymap.set(
                { "n", "x", "o" },
                "]F",
                function() move.goto_next_end("@function.outer", "textobjects") end,
                { desc = "Next function end" }
            )
            vim.keymap.set(
                { "n", "x", "o" },
                "[F",
                function() move.goto_previous_end("@function.outer", "textobjects") end,
                { desc = "Prev function end" }
            )
            vim.keymap.set(
                { "n", "x", "o" },
                "]C",
                function() move.goto_next_start("@class.outer", "textobjects") end,
                { desc = "Next class start" }
            )
            vim.keymap.set(
                { "n", "x", "o" },
                "[C",
                function() move.goto_previous_start("@class.outer", "textobjects") end,
                { desc = "Prev class start" }
            )

            vim.keymap.set(
                "n",
                "<leader>a",
                function() swap.swap_next("@parameter.inner") end,
                { desc = "Swap parameter next" }
            )
            vim.keymap.set(
                "n",
                "<leader>A",
                function() swap.swap_previous("@parameter.inner") end,
                { desc = "Swap parameter prev" }
            )
        end,
    },
    {
        -- Only ~/code/work/vision/web has an .editorconfig (indent_size = 2),
        -- which nvim honours natively. Everywhere else JS/Vue/Go inherit the
        -- global shiftwidth of 4 while typing; this infers it from the buffer.
        "NMAC427/guess-indent.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = { override_editorconfig = false },
    },
}
