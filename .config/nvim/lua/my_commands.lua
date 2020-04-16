#! /usr/bin/env lua
--
-- my_commands.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--


local luajob = require('luajob')

local function endswith(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

local function close_git_status()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do 
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if endswith(buf_name, '.git/index') then
      vim.api.nvim_win_close(win, false)
    end
  end
end

M = {}

M.git_push  = function(force) 
  local git_push = luajob:new({
    cmd = 'git push'..(force and ' -f' or ''),
    on_stdout = function(err, data)
      if err then
        vim.cmd.echoerr('error: ', err)
      elseif data then
        lines = vim.fn.split(data, '\n')
        for _, line in ipairs(lines) do
          print(line)
        end
      end
    end,
    on_exit = function(code, signal)
      if code == 0 then
        print('Git push succeeded!')
      end
    end
  })
  git_push:start()
  close_git_status()
end


M.custom_command  = function(command, silent) 
  local job = luajob:new({
    cmd = command,
    on_stdout = function(err, data)
      if err then
        vim.cmd.echoerr('error: ', err)
      elseif data then
        lines = vim.fn.split(data, '\n')
        if not silent then
          for _, line in ipairs(lines) do
            print(line)
          end
        end
      end
    end,
    on_exit = function(code, signal)
      if code == 0 then
        print('"'..command..'" succeeded!')
      end
    end
  })
  job:start()
end


return M
