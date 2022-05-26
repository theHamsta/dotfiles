#! /usr/bin/env lua
--
-- theHamsta_luasnips.lua
-- Copyright (C) 2022 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l

require("luasnip.loaders.from_snipmate").lazy_load()

ls.add_snippets("python", {
	s("fim", {
		t('from '), i(1, 'module'), t(' import '), i(2, 'thing')
	}),
	s("im", {
		t('import '), i(1, 'thing')
	})
})

ls.add_snippets("c", {
	s("inc", {
		t('#include <'), i(1, 'module'), t('>')
	}),
	s("Inc", {
		t('#include "'), i(1, 'module'), t('"')
	}),
})
--ls.add_snippets("cpp", {
	--s("cls",
		--{ {t'class ', i(1,'name')},
		--{{t'{'}},
			--{{t'public:'}}
			--{{i(1), t'()'}}
			--{t'virtual ~', {i(1), t'()'}}
			--{i(1), '(', }
	--$1($1 &&) = default;
	--$1(const $1 &) = default;
	--auto operator=($1 &&) -> $1&  = default;
	--auto operator=(const $1 &) -> $1&  = default;

	--${2}
--private:
	--${3}
--};
	--}),
--})

ls.config.setup({
	load_ft_func =
		-- Also load both lua and json when a markdown-file is opened,
		-- javascript for html.
		-- Other filetypes just load themselves.
		require("luasnip.extras.filetype_functions").extend_load_ft({
			markdown = {"html"},
			html = {"javascript"},
			cuda = {"cpp", "c"},
			cpp = {"c"},
		})
})
