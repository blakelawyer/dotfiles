require("blake.plugins-setup")
require("blake.core.options")
require("blake.core.keymaps")
require("blake.core.colorscheme")
require("blake.plugins.comment")
require("blake.plugins.nvim-tree")
require("blake.plugins.lualine")
require("blake.plugins.telescope")
require("blake.plugins.nvim-cmp")
require("blake.plugins.lsp.mason")
require("blake.plugins.lsp.lspsaga")
require("blake.plugins.lsp.lspconfig")
require("blake.plugins.lsp.null-ls")
require("blake.plugins.autopairs")
require("blake.plugins.treesitter")
require("blake.plugins.gitsigns")
require("blake.plugins.copilot")

vim.g.vimwiki_list = {
	{
		path = "~/vimwiki/",
		syntax = "markdown",
		ext = ".md",
	},
}

vim.g.vimwiki_ext2syntax = {
	[".md"] = "markdown",
	[".markdown"] = "markdown",
	[".mdown"] = "markdown",
}

vim.g.vimwiki_markdown_link_ext = 1
-- vim.g.vimwiki_folding = "list"
