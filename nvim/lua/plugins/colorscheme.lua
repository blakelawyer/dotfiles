return {
    -- Declared as its own eager, higher-priority spec in addition to being listed
    -- in akira's dependencies: colors/akira.lua does an unguarded require('lush'),
    -- so lush must be on the rtp before anything can trigger the colorscheme.
    {
        "rktjmp/lush.nvim",
        lazy = false,
        priority = 1001,
    },
    {
        -- Local checkout so the theme can be iterated on with :Lushify.
        -- Pushes to github.com/blakelawyer/akira.
        dir = "~/code/akira",
        name = "akira",
        lazy = false,
        priority = 1000,
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            -- A local dir has no lockfile entry, so on a machine without
            -- ~/code/akira this would otherwise abort the whole config load.
            if not pcall(vim.cmd.colorscheme, "akira") then
                vim.notify("akira not found at ~/code/akira, falling back", vim.log.levels.WARN)
                vim.cmd.colorscheme("habamax")
            end
        end,
    },
}
