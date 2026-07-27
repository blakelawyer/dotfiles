return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signs_staged = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        current_line_blame_opts = { delay = 400, virt_text_pos = "eol" },
        current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
        preview_config = { border = "rounded" },
        on_attach = function(buf)
            local gs = require("gitsigns")
            local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc }) end

            -- ]h/[h rather than ]c/[c: those are vim's built-in diff-mode motions
            map("n", "]h", function()
                if vim.wo.diff then
                    return "]h"
                end
                vim.schedule(function() gs.nav_hunk("next") end)
                return "<Ignore>"
            end, "Next hunk")
            map("n", "[h", function()
                if vim.wo.diff then
                    return "[h"
                end
                vim.schedule(function() gs.nav_hunk("prev") end)
                return "<Ignore>"
            end, "Prev hunk")

            map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
            map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
            map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
            map("n", "<leader>hd", gs.diffthis, "Diff this")
            map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")
            map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
        end,
    },
}
