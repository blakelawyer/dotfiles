local function augroup(name) return vim.api.nvim_create_augroup("cfg_" .. name, { clear = true }) end

-- highlight on yank (0.12 has no default for this)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("yank"),
    callback = function() vim.hl.on_yank({ higroup = "Visual", timeout = 150 }) end,
})

-- restore the last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(ev)
        if vim.bo[ev.buf].filetype:match("^git") or vim.bo[ev.buf].buftype ~= "" then
            return
        end
        if vim.b[ev.buf].cfg_last_loc then
            return
        end
        vim.b[ev.buf].cfg_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- No LspAttach autocmd here on purpose. 0.12 sets K, grn, gra, grr, gri, grt,
-- grx and gO per-buffer itself, and inlay hints / codelens are switched on
-- globally in plugins/lsp.lua -- see the comment there.

-- prose
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("prose"),
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.relativenumber = false
        vim.opt_local.conceallevel = 2
    end,
})

-- close scratch-ish buffers with q
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = { "help", "man", "qf", "checkhealth", "notify", "query", "lspinfo" },
    callback = function(ev)
        vim.bo[ev.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
    end,
})

-- create missing parent dirs on write
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("mkdir"),
    callback = function(ev)
        if ev.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(ev.match) or ev.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- equalize splits when the terminal resizes
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("resize"),
    callback = function()
        local tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. tab)
    end,
})
