return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup({
            auto_install = true,
        })
        vim.treesitter.language.register("markdown", "markdown")
    end,
}
