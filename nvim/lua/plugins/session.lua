-- Sessions live under <leader>s, not the more common <leader>q: <leader>q is
-- already bound to :quit, and adding <leader>q* would turn it into an ambiguous
-- prefix -- every quit would stall for timeoutlen first.
return {
    "folke/persistence.nvim",
    -- BufReadPre, so a session is only tracked once a real file is opened;
    -- `nvim` with no arguments shouldn't clobber the saved session.
    event = "BufReadPre",
    opts = {},
    keys = {
        { "<leader>ss", function() require("persistence").load() end, desc = "Restore session (cwd)" },
        { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
        { "<leader>sf", function() require("persistence").select() end, desc = "Pick a session" },
        { "<leader>sd", function() require("persistence").stop() end, desc = "Don't save this session" },
    },
}
