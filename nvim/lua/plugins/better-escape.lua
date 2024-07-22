return {
    "max397574/better-escape.nvim", tag = 'v1.0.0',
    config = function()
        require("better_escape").setup({
            mapping = { "jk", "jj", "kj" },
            timeout = vim.o.timeoutlen,
            keys = "<Esc>",
        })
    end,
}
