return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>h", group = "hunk" },
            { "<leader>c", group = "code" },
            { "<leader>u", group = "ui/toggle" },
            { "<leader>b", group = "buffer" },
            { "g", group = "goto" },
            { "gr", group = "lsp" },
            { "]", group = "next" },
            { "[", group = "prev" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer keymaps",
        },
    },
}
