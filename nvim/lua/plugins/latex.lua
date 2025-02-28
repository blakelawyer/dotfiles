return {
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_method = "zathura"      -- use Zathura for PDF viewing (optional)
      vim.g.vimtex_compiler_progname = "nvr"
    end
  }
}
