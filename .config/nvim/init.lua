--
-- init.lua
-- Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

--require'nvim_lsp'.clangd.setup{}
--require'nvim_lsp'.pyls.setup{}
--require'nvim_lsp'.pyls_ms.setup{}
-- Courtesy of @norcalli
--local function plug(path, config)
    --vim.validate {
        --path = {path, "s"},
        --config = {config, vim.tbl_islist, "an array of packages"}
    --}
    --vim.fn["plug#begin"](path)
    --for _, v in ipairs(config) do
        --if type(v) == "string" then
            --vim.fn["plug#"](v)
        --elseif type(v) == "table" then
            --local p = v[1]
            --assert(p, "Must specify package as first index.")
            --v[1] = nil
            --vim.fn["plug#"](p, v)
            --v[1] = p
        --end
    --end
    --vim.fn["plug#end"]()
    --vim._update_package_paths()
--end

--vim.api.nvim_command [[
    --function! DeleteTrailingWS()
      --exe 'normal mz'
      --%s/\s\+$//ge
      --exe 'normal `z'
    --endfunction
--]]
local nvim_lsp = require "nvim_lsp"

----nvim_lsp.clangd.setup({
----cmd={"clangd-11", "--clang-tidy", "--header-insertion=iwyu", "--background-index", "--suggest-missing-includes"}
----})
--local function pcall_ret(status, ...)
    --if status then
        --return ...
    --end
--end

--local function nil_wrap(fn)
    --return function(...)
        --return pcall_ret(pcall(fn, ...))
    --end
--end
nvim_lsp.sumneko_lua.setup {
    settings = {Lua = {diagnostics = {globals = {"vim", "map", "filter", "range", "reduce"}}}}
}

nvim_lsp.vimls.setup {}
nvim_lsp.yamlls.setup {}
nvim_lsp.jsonls.setup {}
--nvim_lsp.rust_analyzer.setup({})

nvim_lsp.texlab.setup {
    settings = {
        latex = {
            build = {
                onSave = false
            },
            lint = {
                onChange = true
            }
        }
    }
}
--nvim_lsp.texlab.buf_build({bufnr})

local ok, colorizer = pcall(require, "colorizer")
if ok then
    colorizer.setup {
        "css",
        "javascript",
        "tex",
        "html",
        "vim",
        "tex"
    }
end

local ok, dap = pcall(require, "dap")
if ok then
    dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = {"-m", "debugpy.adapter"}
    }
                --"internalConsole",
                --"integratedTerminal",
                --"externalTerminal",
    dap.configurations.python = {
        {
            type = "python",
            request = "attach",
            name = "Launch file",
            program = "${file}",
            console = "internalConsole"
            --pythonPath = function()
            --return "/usr/bin/python3"
            --end
        },
        {
            type = "python",
            request = "attach",
            name = "Pytest file",
            program = "-m pytest ${file}",
            console = "externalTerminal"
            --return "/usr/bin/python3"
            --end
        },
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            console = "internalConsole"
            --pythonPath = function()
            --return "/usr/bin/python3"
            --end
        },
    }
    dap.repl.commands = {
        continue = {".continue", "c"},
        next_ = {".next", "n"},
        into = {".into", "s"},
        out = {".out", "r"},
        scopes = {".scopes", "a"},
        threads = {".threads", "t"},
        frames = {".frames", "f"},
        exit = {"exit", ".exit"},
        up = {".up", "up"},
        down = {".down", "down"},
        goto_ = {".goto", "j"}
    }
    vim.g.dap_virtual_text = true
end

vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})

local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
    require "nvim-treesitter.configs".get_parser_configs().lisp = {
        install_info = {
            url = "https://github.com/theHamsta/tree-sitter-clojure",
            files = {"src/parser.c"}
        }
    }
    require "nvim-treesitter.configs".get_parser_configs().clojure = {
        install_info = {
            url = "https://github.com/oakmac/tree-sitter-clojure",
            files = {"src/parser.c"}
        }
    }
    require "nvim-treesitter.configs".setup(
        {
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {'lua'} -- list of language that will be disabled
            },
            incremental_selection = {
                -- this enables incremental selection
                enable = true,
                disable = {},
                keymaps = {
                    -- mappings for incremental selection (visual mappings)
                    node_incremental = "<a-k>", -- "grn" by default,
                    scope_incremental = "<a-j>" -- "grc" by default
                }
            },
            node_movement = {
                -- this enables incremental selection
                enable = true,
                highlight_current_node = false,
                disable = {},
                keymaps = {
                    move_up = "<a-k>",
                    move_down = "<a-j>",
                    move_left = "<a-h>",
                    move_right = "<a-l>",
                    select_current_node = "<leader>ff"
                }
            },
            ensure_installed = "all"
        }
    )
    require "nvim-treesitter".setup()

    require "nvim_rocks".ensure_installed({"luasec", "fun", "30log", "lua-toml", 'template'})
end

require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.TSHighlighter.hl_map

-- Misc
hlmap.error = "Error"
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = "Delimiter"

-- Constants
hlmap["constant"] = "Constant"
hlmap["constant.builtin"] = "Type"
hlmap["constant.macro"] = "Define"
hlmap["string"] = "String"
hlmap["string.regex"] = "String"
hlmap["string.escape"] = "SpecialChar"
hlmap["character"] = "Character"
hlmap["number"] = "Number"
hlmap["boolean"] = "Boolean"
hlmap["float"] = "Float"

-- Functions
hlmap["function"] = "Function"
hlmap["function.builtin"] = "Special"
hlmap["function.macro"] = "Macro"
hlmap["parameter"] = "Identifier"
hlmap["method"] = "Function"
hlmap["field"] = "Identifier"
hlmap["property"] = "Identifier"
hlmap["constructor"] = "Type"

-- Keywords
hlmap["conditional"] = "Conditional"
hlmap["repeat"] = "Repeat"
hlmap["label"] = "Label"
hlmap["operator"] = "Operator"
hlmap["keyword"] = "Repeat"
hlmap["exception"] = "Exception"

hlmap["type"] = "Type"
hlmap["type.builtin"] = "Type"
hlmap["structure"] = "Structure"
--
vim.cmd("command! JustTargets lua require'my_launcher'.fuzzy_just()<cr>")


vim.api.nvim_command [[
    command! -nargs=1 JustRun lua require "my_launcher".run_just_task(<f-args>)
]]

--vim.api.nvim_command [[
    --command! -nargs=1 JustTargets lua require "my_launcher".fuzzy_just(<f-args>)
--]]
