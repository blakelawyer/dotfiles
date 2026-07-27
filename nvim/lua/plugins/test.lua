-- Adapters match what ~/code/work actually runs:
--   pytest  -- 58 test files, pyproject.toml in gen6/herakles and vision/jarvis
--   vitest  -- web/
--   jest    -- api/ ("test": "jest tests/unit")
--   go test -- one _test.go, but gopls is configured so the adapter comes along
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "marilari88/neotest-vitest",
        "nvim-neotest/neotest-jest",
        "fredrikaverpil/neotest-golang",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                -- dap = false: no nvim-dap in this config, so debug strategy is
                -- unavailable and asking for it would only error at runtime.
                require("neotest-python")({ dap = false, runner = "pytest" }),
                require("neotest-vitest"),
                require("neotest-jest")({ jestCommand = "npx jest --" }),
                require("neotest-golang"),
            },
            status = { virtual_text = true, signs = true },
            output = { open_on_run = true },
            quickfix = { enabled = false },
        })
    end,
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
        {
            "<leader>tf",
            function() require("neotest").run.run(vim.fn.expand("%")) end,
            desc = "Run file",
        },
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
        {
            "<leader>to",
            function() require("neotest").output.open({ enter = true, auto_close = true }) end,
            desc = "Show output",
        },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test run" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle watch" },
    },
}
