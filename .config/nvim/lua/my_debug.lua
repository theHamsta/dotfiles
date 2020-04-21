#! /usr/bin/env lua
--
-- my_debug.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--


local luajob = require('luajob')

local function luajob_on_stdout(err, data)
  if err then
    vim.cmd.echoerr('error: ', err)
  elseif data then
    lines = vim.fn.split(data, '\n')
    for _, line in ipairs(lines) do
      print(line)
    end
  end
end 

M = {
  default_port = 5788
}

M.set_debug_target = function(is_pytest)
  M.debug_target = (is_pytest and '-m pytest ' or '')..vim.fn.expand('%:p')
end

M.start_debugpy = function (target, port)
  M.debugpy = luajob:new({
    cmd = 'python3 -m debugpy --listen localhost:'..tostring(port or M.default_port)..' --wait-for-client '..target,
    on_stdout = luajob_on_stdout,
    on_stderr = luajob_on_stdout,
    on_exit = function(code, signal)
      if code == 0 then
        print('debugpy terminated!')
      end
    end
  })
  M.debugpy:start()
end

M.start_python_debugger = function(use_this_file, is_pytest)
  if use_this_file then
    M.set_debug_target(is_pytest)
  end
  if M.debugpy then
    M.debugpy:stop()
  end
  print("Debugging "..M.debug_target)

  if not M.debug_target then
    vim.cmd('echoerr "No debug target set!"')
  end

  M.start_debugpy(M.debug_target, M.default_port)
  os.execute('sleep 1.2')
  dap = require'dap'
  dap.attach('127.0.0.1', M.default_port, dap.configurations.python[1])
  M.default_port = M.default_port + 1
end

return M
