-- Anthropic ships official IDE extensions for VS Code and JetBrains only. This
-- is a pure-Lua reimplementation of the same WebSocket/MCP protocol, so the
-- `claude` CLI talks to nvim the way it talks to those editors: it sees the
-- current selection and open buffers, and proposes edits as native diffs.
--
-- Requires the claude CLI on PATH (already there via ~/.local/bin/claude).
--
-- No `version` pin on purpose. The newest release tag is v0.3.0 from Sep 2025,
-- but main has carried on through 2026 -- pinning to tags would strand us ten
-- months back, including several diff fixes. lazy-lock.json is the real pin.
return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        terminal = {
            -- "auto" would resolve to snacks anyway; naming it keeps the choice
            -- from silently changing if the detection order ever does.
            provider = "snacks",
            split_side = "right",
            split_width_percentage = 0.35,
        },
        diff_opts = {
            layout = "vertical",
            auto_resize_terminal = true,
        },
    },
    -- stylua: ignore
    cmd = {
        "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSelectModel", "ClaudeCodeAdd",
        "ClaudeCodeSend", "ClaudeCodeTreeAdd", "ClaudeCodeStatus", "ClaudeCodeStart",
        "ClaudeCodeStop", "ClaudeCodeOpen", "ClaudeCodeClose", "ClaudeCodeDiffAccept",
        "ClaudeCodeDiffDeny", "ClaudeCodeCloseAllDiffs",
    },
    keys = {
        -- Terminal-mode escape hatch, because <leader>ac cannot work from inside
        -- the Claude window and cannot be made to.
        --
        -- Leader is Space, and Claude's prompt takes Space as literal text. A
        -- t-mode "<Space>ac" would therefore match ordinary prose: typing
        -- "fix this according to the docs" resolves " ac" as the mapping and
        -- yields "fix thiscording to the docs" with the window toggled shut
        -- mid-sentence. The whole <leader>a family collides the same way --
        -- " ad"d, " as", " ab"out, " ar"e are all words you'd type to Claude.
        --
        -- M-Space is the nearest safe thing: still the space bar, but modified,
        -- so it can never be confused with text. Free here -- i3 uses Mod4, so
        -- $mod+space is Super+Space, and Alacritty doesn't rebind it.
        { "<M-Space>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Toggle Claude" },
        -- Fallback for terminals that swallow M-Space. t-mode only: in normal
        -- mode CTRL-Q is a built-in alias for CTRL-V.
        { "<C-q>", "<cmd>ClaudeCode<cr>", mode = "t", desc = "Hide Claude" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        { "<leader>a?", "<cmd>ClaudeCodeStatus<cr>", desc = "Connection status" },
    },
}
