-- <Space>ac from inside the Claude terminal prompt, without eating prose.
--
-- Leader is Space, and Space is also the character between every word typed to
-- Claude, so a plain t-mode <Space>ac map matches mid-sentence: "according"
-- loses its " ac" and the window slams shut. Prose and a deliberate leader
-- press carry the same characters -- what differs is the TIMING around them.
-- " ac" inside a word is always followed by another key within a fraction of a
-- second; "Space a c" pressed as a chord is followed by silence.
--
-- So the Claude buffer maps bare <Space> (see snacks_win_opts in
-- plugins/claude.lua) to this: peek at what follows the space, and either
-- toggle or replay everything into the terminal untouched.

local M = {}

local KEY_MS = 400 -- max gap between Space->a and a->c (matches &timeoutlen)
local TAIL_MS = 350 -- silence required after "ac" before toggling

-- Keys typed while this callback is running land in the typeahead, where
-- getchar(1) can see them without consuming; getcharstr(0) then takes one.
local function next_key(ms)
    local ok = vim.wait(ms, function() return vim.fn.getchar(1) ~= 0 end, 10)
    return ok and vim.fn.getcharstr(0) or nil
end

-- "n": noremap, so the replayed Space can't re-trigger this map.
-- "i": insert at the FRONT of the typeahead, ahead of keys that arrived while
--      we were peeking -- without it the flushed text lands out of order
--      ("hi there." became "hihere. t" in testing).
-- Special keys (arrows, <BS>) come out of getcharstr in internal termcode
-- form, which feedkeys accepts verbatim, so they replay correctly too.
local function flush(keys) vim.api.nvim_feedkeys(keys, "ni", false) end

-- Swappable in tests, where launching the real claude CLI is unwanted.
M.toggle = function() vim.cmd("ClaudeCode") end

function M.on_space()
    local c1 = next_key(KEY_MS)
    if c1 ~= "a" then
        return flush(" " .. (c1 or ""))
    end
    local c2 = next_key(KEY_MS)
    if c2 ~= "c" then
        return flush(" a" .. (c2 or ""))
    end
    local c3 = next_key(TAIL_MS)
    if c3 then
        return flush(" ac" .. c3)
    end
    M.toggle()
end

return M
