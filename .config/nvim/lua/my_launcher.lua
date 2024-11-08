local my_commands = require "my_commands"

local M = {}

function M.get_just_program()
    return vim.fn.empty(vim.fn.glob("./justfile")) == 1 and
        "just --justfile " .. vim.fn.expand("~/.justfile") .. " --working-directory ." or
        "just"
end

M.list_just_targets = function()
    local just_program = M.get_just_program()
    local just_files = vim.fn.systemlist(just_program.." --list")
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
    vim.g.last_execution = cmd
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
    local just_program = M.get_just_program()
    if async then
        my_commands.do_luajob(just_program..' '..task)
    else
        M.term_run(just_program..' '..task)
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
