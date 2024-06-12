require('nvim-treesitter.configs').setup {

  ensure_installed = {
	  "c",
	  "vim",
	  "vimdoc", 
	  "python",
	  "bash",
	  "css",
	  "html",
	  "yaml",
	  "javascript",
	  "json",
  },

  indent = { enable = true },

  sync_install = false,

  auto_install = true,

  ignore_install = { "lua", "markdown"},

  highlight = {
    enable = true,
    disable = {"lua", "markdown", "rust", "html", "javascript"},
  },
}
