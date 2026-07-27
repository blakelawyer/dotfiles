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
    config = function(_, opts)
        require("claudecode").setup(opts)
        -- vim.on_key observer that makes ALL leader combos work from INSIDE
        -- the prompt without adding any typing latency (minus a few prose-like
        -- sequences it denylists) -- see the comment block in
        -- config/claude_space.lua for how chords are disambiguated from prose.
        require("config.claude_space").attach()
    end,
    -- stylua: ignore
    cmd = {
        "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSelectModel", "ClaudeCodeAdd",
        "ClaudeCodeSend", "ClaudeCodeTreeAdd", "ClaudeCodeStatus", "ClaudeCodeStart",
        "ClaudeCodeStop", "ClaudeCodeOpen", "ClaudeCodeClose", "ClaudeCodeDiffAccept",
        "ClaudeCodeDiffDeny", "ClaudeCodeCloseAllDiffs",
    },
    keys = {
        -- Inside the prompt, these (and every other leader combo) also work:
        -- config/claude_space (attached in config above) watches the key
        -- stream for leader chords.
        -- Fallback in case the timing heuristic ever misbehaves. t-mode only:
        -- in normal mode CTRL-Q is a built-in alias for CTRL-V.
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
