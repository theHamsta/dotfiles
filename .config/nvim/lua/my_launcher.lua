require "nvim_rocks".ensure_installed({"luasec", "fun" })
if not filter then
    require "fun"()
end
local my_commands = require "my_commands"

M = {}

M.list_just_targets = function()
    local just_files = vim.fn.systemlist("just --list")
    table.remove(just_files, 1)
    for i, v in map(
        function(s)
            return s:gsub("^%s+(%S*).*", "%1")
        end,
        just_files
    ) do
        just_files[i] = v
    end
    return just_files
end

M.term_run = function(cmd)
    local win = vim.api.nvim_get_current_win()
    vim.cmd("normal <c-w>o")
    vim.cmd("vert new")
    --local term_win = vim.api.nvim_get_current_win()

    local opts = {
        clear_env = false,
        detach = true
    }
    local _ = vim.fn.termopen(cmd, opts)
    vim.bo.bufhidden = "wipe"
    vim.api.nvim_set_current_win(win)
end

M.run_just_task = function(task, async)
    if async then
        my_commands.do_luajob("just " .. task)
    else
        M.term_run("just " .. task)
    end
end

M.fuzzy_just = function(async)
    vim.fn["fzf#run"](
        {
            source = M.list_just_targets(),
            sink = async and "JustRunAsync" or "JustRun",
            window = "call FloatingFZF()"
        }
    )
end


return M
