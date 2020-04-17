#! /usr/bin/env lua
--
-- my_debug.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--



M = {}

M.debug_target = nil

M.set_debug_target = function()
  M.debug_target = vim.fn.expand('%:p')
end

M.start_python_debugger = function(use_this_file)
  if use_this_file then
    M.set_debug_target()
  end

  if not M.debug_target then
    vim.cmd('echoerr "No debug target set!"')
  end

  vim.cmd(':T python3 -m debugpy --listen localhost:5678 --wait-for-client '.. M.debug_target)
  os.execute('sleep 0.5')
  require'dap'.attach({port=5678})
end

return M
