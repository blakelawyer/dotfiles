return {
  -- Markdown preview (manual start)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },

  -- Distraction-free writing
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>wm", "<cmd>ZenMode<cr>", desc = "Writing Mode" },
    },
    opts = {
      on_open = function()
        vim.cmd("SoftPencil")
        vim.opt.spell = true
        vim.opt.number = false
        vim.opt.relativenumber = false
      end,
      on_close = function()
        vim.cmd("NoPencil")
        vim.opt.spell = false
        vim.opt.number = true
        vim.opt.relativenumber = true
      end,
    },
  },

  -- Soft line wrapping
  {
    "preservim/vim-pencil",
    cmd = { "Pencil", "SoftPencil", "HardPencil" },
  },

  -- Inline markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      render_modes = { 'n', 'c', 'i', 'v' },  -- Render in all modes
    },
  },
}
