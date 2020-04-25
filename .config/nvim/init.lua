#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

--require'nvim_lsp'.clangd.setup{}
--require'nvim_lsp'.pyls.setup{}
local nvim_lsp  =require'nvim_lsp'

--nvim_lsp.clangd.setup({
    --cmd={"clangd-11", "--clang-tidy", "--header-insertion=iwyu", "--background-index", "--suggest-missing-includes"}
--})

require'nvim_lsp'.sumneko_lua.setup{
  settings = {Lua = { diagnostics = {globals = {'vim'}}}}
}

require 'colorizer'.setup {
  'css';
  'javascript';
  'tex';
  'html';
  'tex';
}

local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python3';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python ={
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python3'
    end;
  },
  {
    type = 'python';
    request = 'launch';
    name = "Pytest file";
    program = "-m pytest ${file}";
    pythonPath = function()
      return '/usr/bin/python3'
    end;
  },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})


--require'nvim-treesitter'.setup('rust')
--require'nvim-treesitter'.setup('cpp')
----r'equire'nvim-treesitter'.setup('ruby')
--
require'nvim_rocks'.ensure_installed({'fun', '30log', 'lua-toml'})
