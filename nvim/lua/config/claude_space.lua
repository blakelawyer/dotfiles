-- <Space>ac from inside the Claude terminal prompt, with zero typing latency.
--
-- Leader is Space, and Space is also the character between every word typed to
-- Claude, so a plain t-mode <Space>ac map matches mid-sentence. The first cut
-- of this module intercepted <Space> and blocked in vim.wait to peek at the
-- next key -- which made every space render a beat late and typing feel laggy.
--
-- This version never intercepts anything. Keys flow to Claude's pty untouched,
-- and vim.on_key OBSERVES the stream after the fact (it runs post-processing
-- and cannot delay input). A state machine watches for the leader signature --
-- Space, a, c, then ~350ms of stillness; prose never matches because " ac"
-- mid-word ("according", "actually") always has another key hot on its heels.
-- When the chord completes, the " ac" that already reached the prompt is
-- erased with three backspaces and the window toggles.
--
-- Paste can't trigger this: terminal paste goes vim.paste -> nvim_put, which
-- never produces key events. Mouse/arrows/anything off-pattern just resets.

local M = {}

local KEY_MS = 400 -- max gap Space->a and a->c
local TAIL_MS = 350 -- silence after "ac" that confirms the chord

local state = 0 -- 0 idle | 1 saw Space | 2 saw a | 3 armed (saw c)
local last = 0
local timer = vim.uv.new_timer()

-- Swappable in tests, where launching the real claude CLI is unwanted.
M.toggle = function() vim.cmd("ClaudeCode") end

local function claude_buf()
    local ok, term = pcall(require, "claudecode.terminal")
    return ok and term.get_active_terminal_bufnr() or nil
end

local function fire()
    vim.schedule(function()
        if state ~= 3 then
            return
        end
        state = 0
        local buf = claude_buf()
        if not buf then
            return
        end
        local job = vim.b[buf].terminal_job_id
        if job then
            -- The chord's " ac" already landed in the prompt; DEL x3 takes it
            -- back out before hiding the window.
            vim.fn.chansend(job, string.rep("\127", 3))
        end
        M.toggle()
    end)
end

function M.attach()
    -- Runs on every keypress session-wide, so cheapest checks first. Also:
    -- on_key callbacks are silently REMOVED on error -- keep this body safe.
    vim.on_key(function(key, typed)
        local k = typed ~= "" and typed or key
        if vim.api.nvim_get_mode().mode ~= "t" then
            state = 0
            return
        end
        if vim.api.nvim_get_current_buf() ~= claude_buf() then
            state = 0
            return
        end
        local now = vim.uv.now()
        local gap = now - last
        last = now
        timer:stop()
        if k == " " then
            state = 1
        elseif k == "a" and state == 1 and gap <= KEY_MS then
            state = 2
        elseif k == "c" and state == 2 and gap <= KEY_MS then
            state = 3
            timer:start(TAIL_MS, 0, fire)
        else
            state = 0
        end
    end)
end

return M
