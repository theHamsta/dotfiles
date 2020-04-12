#! /usr/bin/env lua
--
-- my_gui.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local M = {}

local original_fontsize

if not original_fontsize then
    original_fontsize = vim.g.my_fontsize 
end

local update_font = function()
    vim.cmd("call rpcnotify(1, 'Gui', 'Font', '" .. vim.g.my_font .. " " .. vim.g.my_fontsize .. "')")
end

M.increase_fontsize = function()
    vim.g.my_fontsize = vim.g.my_fontsize + 1
    update_font()
end

M.decrease_fontsize = function()
    vim.g.my_fontsize = vim.g.my_fontsize - 1
    update_font()
end

M.set_fontsize = function(value)
    vim.g.my_fontsize = value
    update_font()
end

M.reset_fontsize = function()
    vim.g.my_fontsize = original_fontsize
    update_font()
end

return M
