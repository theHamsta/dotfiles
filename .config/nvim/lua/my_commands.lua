#! /usr/bin/env lua
--
-- my_commands.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--


local luajob = require('luajob')

M = {}

M.git_push  = function(force) 
  if force then 
    suffix = ' -f'
  else
    suffix = ''
  end
  local git_push = luajob:new({
    cmd = 'git push'..suffix,
    on_stdout = function(err, data)
      if err then
        print('error: ', err)
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
      else
        print('Git push failed!')
      end
    end
  })
  git_push:start()
end




return M
