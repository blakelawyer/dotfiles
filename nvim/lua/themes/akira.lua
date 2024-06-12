-- Thanks to original theme for existing https://github.com/sam4llis/nvim-tundra
-- this is a modified version of it

local M = {}

M.base_30 = {
  white = "#effffe",
  darker_black = "#0b1221",
  black = "#111827", --  nvim bg
  black2 = "#1a2130",
  one_bg = "#1e2534",
  one_bg2 = "#282f3e",
  one_bg3 = "#323948",
  grey = "#3e4554",
  grey_fg = "#4a5160",
  grey_fg2 = "#545b6a",
  light_grey = "#5f6675",
  red = "#FCA5A5",
  baby_pink = "#FECDD3",
  pink = "#ff8e8e",
  line = "#282f3e", -- for lines like vertsplit
  green = "#B5E8B0",
  vibrant_green = "#B5E8B0",
  nord_blue = "#9baaf2",
  blue = "#A5B4FC",
  yellow = "#f8dc75",
  sun = "#f8dc75",
  purple = "#BDB0E4",
  dark_purple = "#b3a6da",
  teal = "#719bd3",
  orange = "#FBC19D",
  cyan = "#BAE6FD",
  statusline_bg = "#171e2d",
  lightbg = "#282f3e",
  pmenu_bg = "#FCA5A5",
  folder_bg = "#A5B4FC",
}

M.base_16 = {
    base00 = "#1f1f39", -- background
    base01 = "#6be28d", -- lime_wire
    base02 = "#b3e3f2", -- cyan_wire
    base03 = "#608e6e", -- green_wire
    base04 = "#f8dc75", -- yellow_wire
    base05 = "#9aa4ca", -- foreground
    base06 = "#ca5c26", -- undecided
    base07 = "#5e7eb5", -- blue_wire
    base08 = "#ff2e2e", -- red_wire
    base09 = "#ca5c26", -- undecided
    base0A = "#f8dc75", -- yellow_wire
    base0B = "#6be28d", -- lime_wire
    base0C = "#b3e3f2", -- cyan_wire
    base0D = "#5e7eb5", -- blue_wire
    base0E = "#ca5c26", -- undecided
    base0F = "#ff2e2e", -- red_wire
}


M.type = "dark"

M = require("base46").override_theme(M, "akira")

return M
