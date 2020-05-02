#! /usr/bin/env lua
--
-- my_projects.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local util = require'nvim_lsp.util'

local function get_projects()
  local roots = {}
  local bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(bufs) do
    local maybe_root = util.find_git_ancestor(util.path.dirname(vim.api.nvim_buf_get_name(buf)))
    if maybe_root then
      roots[maybe_root] = 1
    end
  end
  return roots
end

local function get_project_files()
  local roots = get_projects()
  local result = {}
  for dir, _ in pairs(roots) do
    local files = vim.fn.systemlist("cd "..dir.." && rg --files")
    for _, file in ipairs(files) do
      table.insert(result, dir..'/'..file)
    end
  end
  return result
end


local api = vim.api

local function nvim_loaded_buffers()
  local result = {}
  local buffers = api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if api.nvim_buf_is_loaded(buf) then
      table.insert(result, buf)
    end
  end
  return result
end

-- from
-- Kill the target buffer (or the current one if 0/nil)
local function buf_kill(target_buf, should_force)
  if not should_force and vim.bo.modified then
    return api.nvim_err_writeln('Buffer is modified. Force required.')
  end
  local command = 'bd'
  if should_force then command = command..'!' end
  if target_buf == 0 or target_buf == nil then
    target_buf = api.nvim_get_current_buf()
  end
  local buffers = nvim_loaded_buffers()
  if #buffers == 1 then
    api.nvim_command(command)
    return
  end
  local nextbuf
  for i, buf in ipairs(buffers) do
    if buf == target_buf then
      nextbuf = buffers[(i - 1 + 1) % #buffers + 1]
      break
    end
  end
  api.nvim_set_current_buf(nextbuf)
  api.nvim_command(table.concat({command, target_buf}, ' '))
end

local function close_project(buf)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if util.path.is_dir(buf_name) then
      return
    end
    local maybe_root = util.find_git_ancestor(util.path.dirname(buf_name))
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      local root = util.find_git_ancestor(util.path.dirname(vim.api.nvim_buf_get_name(buf)))
      if root == maybe_root then
        buf_kill(buf)
      end
    end
end

local function get_project_list()
  local projects = get_projects()
  local result = {}
  for k, _ in pairs(projects) do
    table.insert(result, k)
  end
  return result
end

local function get_plugin_readmes()
  local readmes = api.nvim_get_runtime_file('README.md', true)

  return readmes
end

return {
  get_projects = get_projects,
  get_plugin_readmes = get_plugin_readmes,
  get_project_list = get_project_list,
  get_project_files = get_project_files,
  close_project = close_project
}

