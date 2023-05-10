vim.g["everforest_background"] = "hard"
local status, _ = pcall(vim.cmd, "colorscheme nvimgelion")
if not status then
	print("Colorscheme not found!")
	return
end
