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
}
