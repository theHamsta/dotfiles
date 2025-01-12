#! /usr/bin/env lua
--
-- theHamsta_luasnips.lua
-- Copyright (C) 2022 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l

require("luasnip.loaders.from_snipmate").lazy_load {
  paths = vim.tbl_filter(function(elt)
    elt:find("vim-snippets", nil, true)
  end, vim.api.nvim_get_runtime_file("snippets", true)),
}
require("luasnip.loaders.from_vscode").lazy_load {
  paths = vim.tbl_filter(function(elt)
    elt:find("friendly-snippets", nil, true)
  end, vim.api.nvim_get_runtime_file("snippets", true)),
}

ls.add_snippets("python", {
  s("fim", {
    t "from ",
    i(1, "module"),
    t " import ",
    i(2, "thing"),
  }),
  s("im", {
    t "import ",
    i(1, "thing"),
  }),
})

ls.add_snippets("c", {
  s("inc", {
    t "#include <",
    i(1, "module"),
    t ">",
  }),
  s("Inc", {
    t '#include "',
    i(1, "module"),
    t '"',
  }),
})

ls.filetype_extend("cuda", { "cpp", "c" })
ls.filetype_extend("cpp", { "c" })
