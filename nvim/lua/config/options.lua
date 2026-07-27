vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.breakindent = true

-- ui
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.linebreak = true
opt.pumheight = 12
opt.showmode = false -- lualine renders the mode
opt.winborder = "rounded"
-- normally auto-detected from the terminal, but the probe can fail over ssh/tmux
opt.termguicolors = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- splits
opt.splitright = true
opt.splitbelow = true

-- editing / persistence
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.confirm = true
opt.clipboard = "unnamedplus"

opt.spelllang = { "en_us" }

opt.foldlevel = 99
opt.foldenable = true

-- Deliberately not set, because nvim 0.12 already defaults them this way:
-- autoindent, backspace, wrap, background=dark, mouse, inccommand, splitkeep,
-- jumpoptions, hlsearch, incsearch, smarttab, wildoptions.
--
-- list/listchars stay off by choice, not necessity -- akira themes Whitespace now.
