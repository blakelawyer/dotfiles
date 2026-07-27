return {
    "gruvw/strudel.nvim",
    build = "npm ci",
    config = function()
        require("strudel").setup()

        local strudel = require("strudel")
        vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
        vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
        vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Toggle Play/Stop" })
        vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Update code" })
        vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Stop playback" })
        vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Set active buffer" })
        vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Execute current buffer" })
    end,
}
