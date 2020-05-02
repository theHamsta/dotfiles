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

nvim_lsp.sumneko_lua.setup{
  settings = { Lua = { diagnostics = {globals = {'vim'}}}}
}

nvim_lsp.vimls.setup{}
nvim_lsp.yamlls.setup{}
nvim_lsp.jsonls.setup{}
--nvim_lsp.rust_analyzer.setup({})

nvim_lsp.texlab.setup{
  settings = {
    latex = {
      build = {
        onSave = false;
      },
      lint = {
        onChange = true
      }
    }
  }
}
--nvim_lsp.texlab.buf_build({bufnr})

require 'colorizer'.setup {
  'css';
  'javascript';
  'tex';
  'html';
  'tex';
}

local ok, dap = pcall(require,'dap')
if ok then
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
end

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

local ok, nvim_treesitter = pcall(require,'nvim-treesitter.configs')
if ok then
  require'nvim-treesitter.configs'.setup({
    highlight = {
      enable = true,             -- false will disable the whole extension
      disable = {}, -- list of language that will be disabled
    },
    textobj = {                        -- this enables incremental selection
    enable = true,
    disable = {},
  },
  ensure_installed = 'all'
})
require'nvim-treesitter'.setup()

require'nvim_rocks'.ensure_installed({'fun', '30log', 'lua-toml'})
end

