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
--
--
--
if not filter then
    local ok, _  = pcall(require 'fun')
    if ok then
        vim.o.shell = head(filter( vim.fn.executable, { 'zsh', 'fish', 'bash' }))
    end
end

local ok, nvim_lsp = pcall(require, "nvim_lsp")

if ok then
    pcall(require, "nvim_lsp/sumneko_lua")
    if not require("nvim_lsp/configs").sumneko_lua.install_info().is_installed then
        require("nvim_lsp/configs").sumneko_lua.install()
    end

    nvim_lsp.sumneko_lua.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth"},
                    disable = {"redefined-local"}
                },
                runtime = {version = "LuaJIT"}
            }
        }
    }

    local java = function()
        pcall(require, "nvim_lsp/jdtls")
        if not require("nvim_lsp/configs").jdtls.install_info().is_installed then
            require("nvim_lsp/configs").jdtls.install()
        end
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.codeAction = {
            dynamicRegistration = false;
            codeActionLiteralSupport = {
                codeActionKind = {
                    valueSet = {
                        "source.generate.toString",
                        "source.generate.hashCodeEquals",
                        "source.organizeImports",
                    };
                };
            };
        }
        nvim_lsp.jdtls.setup {
            init_options = {
                bundles = {
                    vim.fn.glob("~/.local/share/nvim/plugged/nvim-jdtls/*.jar")
                },
            },
            capabilities = capabilities,
            on_attach = require('jdtls').setup_dap()
        }
    end
    pcall(java)
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
end
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
        }
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
        goto_ = {".goto", "j"},
        into_targets = {'.into_targets', 't'},
    }
    vim.g.dap_virtual_text = true

    dap.adapters.cpp = {
        name = "cppdbg",
        command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
        args = {},
        attach = {
            pidProperty = "processId",
            pidSelect = "ask"
        },
        --configuration = {
            --type = "cppdbg",
            --args = {},
            --cwd = "${workspaceRoot}",
            --environment = {}
        --}
    }
    dap.configurations.java = {
        {
            type = 'java';
            request = 'attach';
            name = "Debug (Attach) - Remote";
            hostName = "127.0.0.1";
            port = 5005;
        },
    }
    dap.adapters.lldb = {
      attach = {
        pidProperty = "pid",
        pidSelect = "ask"
      },
      command = 'lldb-vscode-11',
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
      },
      name = "lldb"
    }
    dap.adapters.markdown = {
        name = "cppdbg",
        command = 'npm',
        args = {'run'},
        cwd = "/home/stephan/projects/vscode-mock-debug/"
    }
--"<name>: Attach": {
--"adapter": "vscode-cpptools",
--"configuration": {
--"name": "<name>: Attach",
--"type": "cppdbg",
--"request": "attach",
--"program": "<path to binary>",
--"MIMode": "lldb"
--}
--}
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
    require "nvim-treesitter.configs".get_parser_configs().regex = {
        install_info = {
            url = "https://github.com/tree-sitter/tree-sitter-regex",
            files = {"src/parser.c"}
        }
    }
    require "nvim-treesitter.configs".setup(
        {
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = {"lua"} -- list of language that will be disabled
            },
            incremental_selection = {
                -- this enables incremental selection
                enable = true,
                disable = {},
                keymaps = {
                    -- mappings for incremental selection (visual mappings)
                    node_incremental = "ts", -- "grn" by default,
                    scope_incremental = "tS" -- "grc" by default
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
    hlmap["include"] = "Include"

    hlmap["type"] = "Type"
    hlmap["type.builtin"] = "Type"
    hlmap["structure"] = "Structure"
    --hlmap["variable"] = "Normal"
end
--require "nvim_rocks".ensure_installed({"luasec", "fun", "30log", "lua-toml", "template"})

--

vim.cmd [[
    command! JustTargets lua require'my_launcher'.fuzzy_just()<cr>
]]
vim.cmd [[
    command! JustTargetsAsync lua require'my_launcher'.fuzzy_just(true)<cr>
]]
vim.cmd [[
    command! -nargs=1 JustRun lua require "my_launcher".run_just_task(<f-args>)
]]
vim.cmd [[
    command! -nargs=1 JustRunAsync lua require "my_launcher".run_just_task(<f-args>, true)
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugC lua require "my_debug".start_c_debugger({<f-args>}, "gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugRust lua require "my_debug".start_c_debugger({<f-args>}, "gdb", "rust-gdb")
]]
vim.cmd [[
    command! -complete=file -nargs=* DebugLLDB lua require "my_debug".start_vscode_lldb({<f-args>})
]]
vim.cmd [[
    command! -complete=file -nargs=* ReverseDebug lua require "my_debug".reverse_debug({<f-args>})
]]
vim.cmd [[
    command! MockDebug lua require "my_debug".mock_debug()
]]

--vim.api.nvim_command [[
--command! -nargs=1 JustTargets lua require "my_launcher".fuzzy_just(<f-args>)
--]]
