#! /usr/bin/env lua
--
-- init.lua
-- Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

--require'nvim_lsp'.clangd.setup{}
--require'nvim_lsp'.pyls.setup{}
nvim_lsp  =require'nvim_lsp'

nvim_lsp.clangd.setup({
    cmd={"clangd-11", "--clang-tidy", "--header-insertion=iwyu", "--background-index", "--suggest-missing-includes"}
})

