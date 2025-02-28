vim.g.mapleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

local opt = vim.opt
opt.clipboard:append("unnamedplus")
opt.undofile = true
opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.wrap = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.termguicolors = true
