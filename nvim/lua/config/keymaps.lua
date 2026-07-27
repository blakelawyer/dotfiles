-- Only what isn't already a 0.12 default and isn't attached to a plugin spec's `keys`.
--
-- Deliberately NOT mapped:
--   K       -- 0.12 sets it per-buffer on LspAttach, but only if no K map exists.
--              A global map here would suppress that and break K in help/man.
--   gr      -- prefix for the grn/gra/grr/gri/grt/grx defaults. Mapping bare `gr`
--              shadows all six and adds a timeoutlen stall.
--   ]d [d   -- 0.12 defaults, same behaviour.
--   ]b [b   -- 0.12 defaults for buffer nav.
--   ]q [q ]l [l
local map = vim.keymap.set

-- files / quit
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write" })
map("n", "<leader>W", "<cmd>wall<cr>", { desc = "Write all" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qall<cr>", { desc = "Quit all" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<leader>-", "<C-w>s", { desc = "Split below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split right" })

-- window resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Grow window" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Shrink window" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Shrink window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Grow window width" })

-- buffers
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete other buffers" })

-- LSP aliases over the 0.12 gr* defaults (both work)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", { desc = "LSP info" })

-- toggles
map("n", "<leader>uw", function() vim.o.wrap = not vim.o.wrap end, { desc = "Toggle wrap" })
map("n", "<leader>us", function() vim.o.spell = not vim.o.spell end, { desc = "Toggle spell" })
map(
    "n",
    "<leader>ud",
    function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
    { desc = "Toggle diagnostics" }
)
map("n", "<leader>uf", "<cmd>FormatDisable<cr>", { desc = "Disable format-on-save" })
map("n", "<leader>uF", "<cmd>FormatEnable<cr>", { desc = "Enable format-on-save" })

-- visual mode
map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- keep the cursor centred
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
