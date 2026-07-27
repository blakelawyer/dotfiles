-- options must load first: it sets mapleader, which lazy.nvim captures when it
-- registers plugin `keys` specs.
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
