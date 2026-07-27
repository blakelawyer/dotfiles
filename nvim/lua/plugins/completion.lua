return {
    "saghen/blink.cmp",
    -- v2 is in breaking-change churn with no release; lazy-lock.json is the real pin
    version = "1.*",
    event = "InsertEnter",
    -- blink's snippets source scans the rtp for friendly-snippets by name.
    -- LuaSnip is not needed: snippets.preset = "default" uses native vim.snippet.
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "enter", -- <CR> confirms, matching the old nvim-cmp setup
            -- the 'enter' preset puts snippet_forward on <Tab>; select_next goes
            -- first here to keep the old tab-to-cycle muscle memory
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        },
        appearance = { nerd_font_variant = "mono" },
        sources = {
            -- all four are built in; no companion plugins to install
            default = { "lsp", "path", "snippets", "buffer" },
        },
        snippets = { preset = "default" },
        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            menu = { border = "rounded" },
            ghost_text = { enabled = false },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        -- no cargo on this box; the prebuilt binary downloads over curl
        fuzzy = { implementation = "prefer_rust_with_warning" },
        cmdline = { enabled = true, keymap = { preset = "cmdline" } },
    },
    opts_extend = { "sources.default" },
}
