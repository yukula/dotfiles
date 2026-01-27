local M = {}

M.name = "zellij"

---@class opencode.provider.zellij.Opts
---@field width? string|number Floating pane width (eg "45%")
---@field height? string|number Floating pane height (eg "100%")
---@field name? string Pane name
---@field cwd? string CWD for opencode (defaults to nvim cwd)
---@field cmd? string Command to start opencode (must include --port)

---@param args string[]
local function system(args)
    local result = vim.system(args, { text = true }):wait()
    if result.code ~= 0 then
        local stderr = (result.stderr and result.stderr ~= "") and result.stderr or "<none>"
        error("Command failed: " .. table.concat(args, " ") .. "\nstderr:\n" .. stderr, 0)
    end
    return result
end

---@param provider opencode.Provider
---@return boolean|string, ...string|string[]
local function health(provider)
    if vim.fn.executable("zellij") ~= 1 then
        return "`zellij` executable not found in `$PATH`.", {
            "Install `zellij` and ensure it's in your `$PATH`.",
        }
    end

    -- In zellij, ZELLIJ is commonly "0" (still truthy), and session name is set.
    if not vim.env.ZELLIJ_SESSION_NAME and not vim.env.ZELLIJ then
        return "Not running inside a `zellij` session.", {
            "Launch Neovim inside a `zellij` session.",
        }
    end

    if not provider.cmd or not provider.cmd:match("%-%-port") then
        return "Provider `cmd` must include `--port`.", {
            "Set `cmd = 'opencode --port'` (or equivalent) in your provider config.",
        }
    end

    return true
end

---@param provider opencode.Provider
---@return number|nil
local function read_pid(provider)
    local ok, lines = pcall(vim.fn.readfile, provider.pidfile)
    if not ok or not lines or #lines == 0 then
        return nil
    end

    local pid = tonumber(lines[1])
    if not pid then
        return nil
    end

    local probe = vim.system({ "kill", "-0", tostring(pid) }, { text = true }):wait()
    if probe.code ~= 0 then
        pcall(vim.fn.delete, provider.pidfile)
        return nil
    end

    return pid
end

---@class opencode.provider.zellij.StartOpts
---@field restore_focus? boolean

---@param provider opencode.Provider
---@param start_opts? opencode.provider.zellij.StartOpts
local function start(provider, start_opts)
    local ok = health(provider)
    if ok ~= true then
        error(ok, 0)
    end

    if read_pid(provider) then
        return
    end

    vim.fn.mkdir(vim.fn.fnamemodify(provider.pidfile, ":h"), "p")

    local cwd = provider.opts.cwd or vim.fn.getcwd()
    local pidfile_escaped = vim.fn.shellescape(provider.pidfile)
    local script = "umask 077; printf '%s' $$ > " .. pidfile_escaped .. "; exec " .. provider.cmd

    system({
        "zellij",
        "run",
        "--floating",
        "--close-on-exit",
        "--name", tostring(provider.opts.name),
        "--width", tostring(provider.opts.width),
        "--height", tostring(provider.opts.height),
        "-x", tostring(provider.opts.x),
        "-y", tostring(provider.opts.y),
        "--cwd",
        cwd,
        "--",
        "sh",
        "-lc",
        script,
    })

    local restore_focus = start_opts == nil or start_opts.restore_focus ~= false
    if restore_focus then
        pcall(vim.system, { "zellij", "action", "focus-previous-pane" }, { text = true })
    end
end

---@param provider opencode.Provider
local function stop(provider)
    local pid = read_pid(provider)
    if not pid then
        return
    end

    pcall(vim.system, { "kill", tostring(pid) }, { text = true })
    pcall(vim.fn.delete, provider.pidfile)
end

---@param provider opencode.Provider
local function toggle(provider)
    local ok = health(provider)
    if ok ~= true then
        error(ok, 0)
    end

    if read_pid(provider) then
        -- Mimic zellij's default <M-f> (toggle floating panes visibility)
        system({ "zellij", "action", "toggle-floating-panes" })
    else
        -- Explicit toggle: leave focus in the pane
        start(provider, { restore_focus = false })
    end
end

---@param opts? opencode.provider.zellij.Opts
---@return opencode.Provider
function M.new(opts)
    opts = opts or {}

    local state_dir = vim.fn.stdpath("state") .. "/opencode"

    ---@type opencode.Provider
    local provider = {
        name = M.name,
        cmd = opts.cmd or "opencode --port",
        opts = {
            name = opts.name or "opencode",
            width = opts.width or "45%",
            height = opts.height or "99%",
            x = opts.x or "55%",
            y = opts.y or "1%",
            cwd = opts.cwd,
        },
        pidfile = state_dir .. "/zellij-" .. tostring(vim.fn.getpid()) .. ".pid",
    }

    -- Expose provider methods as plain fields.
    -- This is critical because opencode.nvim deep-merges opts (copying tables), which drops metatables.
    provider.health = function()
        return health(provider)
    end
    provider.start = function()
        return start(provider)
    end
    provider.stop = function()
        return stop(provider)
    end
    provider.toggle = function()
        return toggle(provider)
    end

    return provider
end

return M
