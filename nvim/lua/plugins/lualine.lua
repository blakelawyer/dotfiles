return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            -- resolves lualine.themes.akira off the akira rtp entry
            theme = "auto",
            globalstatus = true,
            component_separators = "",
            section_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            -- no "diagnostics": the component reads vim.diagnostic.count(), which
            -- keeps counting while diagnostics are disabled, so it would put the
            -- error/warning tally back in view that plugins/lsp.lua just removed
            lualine_b = { "branch", "diff" },
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
    },
}
