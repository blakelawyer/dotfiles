-- Leader combos from inside the Claude terminal prompt, with zero typing
-- latency.
--
-- Leader is Space, and Space is also the character between every word typed to
-- Claude, so t-mode leader maps can't exist: they'd match mid-sentence. The
-- first cut intercepted <Space> and blocked in vim.wait to peek at the next
-- key -- which held every space for up to 400ms and made typing feel laggy.
--
-- This version never intercepts anything. Keys flow to Claude's pty untouched,
-- and vim.on_key OBSERVES the stream after the fact (it runs post-processing
-- and cannot delay input). What separates a leader chord from prose is TIMING:
-- " ac" mid-word ("according") always has another key hot on its heels, while
-- a deliberate "Space a c" is followed by stillness. So: on each space, build
-- a trie of every normal-mode leader mapping and walk it with the keys that
-- follow; when the walk completes a mapping and ~350ms of silence confirms it,
-- erase the chars that already reached the prompt (backspaces via chansend)
-- and replay the mapping for real from normal mode.
--
-- Paste can't trigger this: terminal paste goes vim.paste -> nvim_put, which
-- never produces key events. Mouse/arrows/anything off-pattern just resets.

local M = {}

local KEY_MS = 400 -- max gap between chord keys
local TAIL_MS = 350 -- silence after a complete match that confirms the chord

-- Sequences that spell prose you'd type into Claude and then pause after --
-- and the pause IS the chord signature, so these would misfire mid-sentence
-- ("I want to <think>..." opening the test-output panel). Chosen with Blake:
-- these never trigger from inside the prompt; they work everywhere else.
local DENY = {
    to = true,
    am = true,
    ad = true,
    us = true,
    uh = true,
    ["|"] = true,
    ["-"] = true,
}

local root = nil -- trie: { [char] = node }, node.fire = lhs when a map ends here
local node = nil -- current walk position; nil = idle
local seq = "" -- chars consumed since the leader Space
local last = 0
local timer = vim.uv.new_timer()

local function claude_buf()
    local ok, term = pcall(require, "claudecode.terminal")
    return ok and term.get_active_terminal_bufnr() or nil
end

-- Global n-mode maps plus the Claude buffer's own (snacks win keys). Lazy.nvim
-- registers real stub mappings for lazy-loaded plugins at startup, so this
-- inventory is complete without loading anything. lhsraw spares us parsing
-- "<Space>" notation.
local function build_trie()
    root = {}
    local maps = vim.api.nvim_get_keymap("n")
    local buf = claude_buf()
    if buf then
        vim.list_extend(maps, vim.api.nvim_buf_get_keymap(buf, "n"))
    end
    for _, m in ipairs(maps) do
        local raw = m.lhsraw or m.lhs
        if raw:sub(1, 1) == " " and #raw > 1 and not DENY[raw:sub(2)] then
            local n = root
            for ch in raw:sub(2):gmatch(".") do
                n[ch] = n[ch] or {}
                n = n[ch]
            end
            n.fire = raw
        end
    end
end

local function fire(lhs, n_erase)
    if vim.api.nvim_get_mode().mode ~= "t" then
        return
    end
    local buf = claude_buf()
    if not buf or vim.api.nvim_get_current_buf() ~= buf then
        return
    end
    local job = vim.b[buf].terminal_job_id
    if job then
        -- The chord already landed in the prompt; DEL it back out first.
        vim.fn.chansend(job, string.rep("\127", n_erase))
    end
    -- Leave t-mode with the unmappable built-in, then replay the mapping as
    -- typed keys so <cmd> maps, Lua callbacks, and which-key all behave. The
    -- observer sees the replay but ignores it: mode is 'n' by then.
    vim.api.nvim_feedkeys(vim.keycode("<C-\\><C-n>"), "n", false)
    vim.api.nvim_feedkeys(lhs, "t", false)
end

function M.attach()
    -- Runs on every keypress session-wide, so cheapest checks first. Also:
    -- on_key callbacks are silently REMOVED on error -- keep this body safe.
    vim.on_key(function(key, typed)
        local k = typed ~= "" and typed or key
        if vim.api.nvim_get_mode().mode ~= "t" then
            node = nil
            return
        end
        if vim.api.nvim_get_current_buf() ~= claude_buf() then
            node = nil
            return
        end
        local now = vim.uv.now()
        local gap = now - last
        last = now
        timer:stop()
        if k == " " then
            -- Every space (re)starts the walk: the LAST space begins the chord.
            build_trie()
            node, seq = root, ""
        elseif node and node[k] and gap <= KEY_MS then
            node, seq = node[k], seq .. k
            if node.fire then
                -- Complete match: arm the confirmation timer. A node that is
                -- also a prefix of a longer map keeps walking if another key
                -- arrives -- that key cancels this timer above.
                local lhs, n_erase = node.fire, #seq + 1
                timer:start(TAIL_MS, 0, function()
                    vim.schedule(function() fire(lhs, n_erase) end)
                end)
            end
        else
            node = nil
        end
    end)
end

return M
