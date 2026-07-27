return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        input = { enabled = true },
        scope = { enabled = true },
        words = { enabled = true },
        rename = { enabled = true },
        statuscolumn = { enabled = true, left = { "mark", "sign" }, right = { "fold", "git" } },
        indent = {
            enabled = true,
            indent = { char = "│" },
            scope = { enabled = true, char = "│" },
            animate = { enabled = false },
        },
        notifier = { enabled = true, timeout = 3000, style = "compact" },
        terminal = {
            win = { style = "terminal", position = "float", border = "rounded" },
        },
        lazygit = {
            -- snacks feeds lazygit a generated theme derived from the current
            -- colorscheme, so akira carries over without a lazygit config file
            configure = true,
        },
        explorer = { enabled = true, replace_netrw = true },
        picker = {
            enabled = true,
            ui_select = true, -- replaces telescope-ui-select
            sources = {
                explorer = {
                    auto_close = false,
                    layout = { preset = "sidebar", preview = false },
                    hidden = true,
                },
                files = { hidden = true },
            },
            win = {
                input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } },
            },
        },
    },
    keys = {
        -- carried over from telescope
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        { "<leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
        -- carried over from neo-tree
        { "<leader>n", function() Snacks.explorer() end, desc = "File explorer" },
        { "<leader>N", function() Snacks.explorer.reveal() end, desc = "Reveal file in explorer" },
        -- new
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
        { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word", mode = { "n", "x" } },
        { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
        { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
        { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification history" },
        { "<leader>f:", function() Snacks.picker.command_history() end, desc = "Command history" },
        -- Terminal. Many terminal emulators send <C-_> for what the keyboard
        -- calls Ctrl+/, so both are mapped to the same toggle.
        { "<C-/>", function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
        { "<C-_>", function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit log" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
        { "<leader>gb", function() Snacks.picker.git_log_file() end, desc = "Git log (file)" },
        -- LSP nav through the picker. Note `gr` itself stays unmapped -- it is the
        -- prefix for nvim 0.12's grn/gra/grr/gri/grt/grx defaults.
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto declaration" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto implementation" },
        { "gY", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
    },
}
