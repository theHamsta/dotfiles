#! /usr/bin/env lua
--
--
-- utils.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local M = {}

function M.collect(iterator)
  local rtn = {}
  for _, e in iterator do
    table.insert(rtn, e)
  end
  return rtn
end

function M.iscallable(x)
  if type(x) == 'function' then
    return true
  elseif type(x) == 'table' then
    local mt = debug.getmetatable(x)
    return type(mt) == "table" and type(mt.__call) == "function"
  else
    return false
  end
end

return M
