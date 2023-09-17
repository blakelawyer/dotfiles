-- vim.g["everforest_background"] = "hard"
local status, _ = pcall(vim.cmd, "colorscheme fluoromachine")
if not status then
	print("Colorscheme not found!")
	return
end

local fm = require("fluoromachine")

fm.setup({
	glow = true,
	theme = "fluoromachine",
	transparent = "full",
})

vim.cmd.colorscheme("fluoromachine")
