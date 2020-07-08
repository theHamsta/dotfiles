--
-- my_commands.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local luajob = require("luajob")

local function endswith(str, ending)
    return ending == "" or str:sub(-(#ending)) == ending
end

local function close_git_status()
    local wins = vim.api.nvim_list_wins()
    if #wins > 1 then
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if endswith(buf_name, ".git/index") then
                vim.api.nvim_win_close(win, false)
            end
        end
    end
end

local function luajob_on_stdout(err, data)
    if err then
        vim.cmd.echoerr("error: ", err)
    elseif data then
        local lines = vim.fn.split(data, "\n")
        for _, line in ipairs(lines) do
            print(line)
        end
    end
end

M = {}

function M.do_luajob(cmd)
    vim.g.last_execution = cmd
    local output = ""
    local on_output = function(err, data)
        if err then
            print(err)
        end
        if data then
            local lines = vim.fn.split(data, "\n")
            for _, line in ipairs(lines) do
                print(line)
                output = output .. "\n" .. line
            end
        end
    end
    local job =
        luajob:new(
        {
            cmd = cmd,
            on_stdout = on_output,
            on_stderr = on_output,
            on_exit = function(code, _)
                if code ~= 0 then
                    print('"' .. cmd .. '" failed!')
                    local win = vim.api.nvim_get_current_win()
                    vim.cmd("vert new")
                    vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, vim.split(output, "\n"))
                    vim.bo.bufhidden = "wipe"
                    vim.bo.modified = false
                    vim.api.nvim_set_current_win(win)
                else
                    print('"' .. cmd .. '" finished!')
                end
            end,
            env = {
                PATH = "/usr/bin/:/bin/:" .. vim.fn.expand("~/.local/bin")
            }
        }
    )
    job:start()
end

M.git_push = function(force)
    local git_push =
        luajob:new(
        {
            cmd = "git push" .. (force and " -f" or ""),
            on_stdout = luajob_on_stdout,
            on_stderr = luajob_on_stdout,
            on_exit = function(code, _)
                if code == 0 then
                    print("Git push succeeded!")
                end
            end
        }
    )
    git_push:start()
    close_git_status()
end

M.custom_command = function(command, silent)
    local job =
        luajob:new(
        {
            cmd = command,
            on_stdout = function(err, data)
                if err then
                    vim.cmd.echoerr("error: ", err)
                elseif data then
                    local lines = vim.fn.split(data, "\n")
                    if not silent then
                        for _, line in ipairs(lines) do
                            print(line)
                        end
                    end
                end
            end,
            on_exit = function(code, _)
                if code == 0 then
                    print('"' .. command .. '" succeeded!')
                end
            end,
            env = {
                PATH = "/usr/bin/:/bin/:" .. vim.fn.expand("~/.local/bin")
            }
        }
    )
    job:start()
end

return M
