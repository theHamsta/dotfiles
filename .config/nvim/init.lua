--
-- init.lua
-- Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

--require'nvim_lsp'.clangd.setup{}
--require'nvim_lsp'.pyls.setup{}

local nvim_lsp = require "nvim_lsp"

--nvim_lsp.clangd.setup({
--cmd={"clangd-11", "--clang-tidy", "--header-insertion=iwyu", "--background-index", "--suggest-missing-includes"}
--})
 local function pcall_ret(status, ...)
    if status then return ... end
  end
  local function nil_wrap(fn)
    return function(...)
      return pcall_ret(pcall(fn, ...))
    end
  end
nvim_lsp.sumneko_lua.setup {
    settings = {Lua = {diagnostics = {globals = {"vim"}}}}
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

    dap.configurations.python = {
        {
            type = "python",
            request = "attach",
            name = "Launch file",
            program = "${file}",
            console = "externalTerminal",
            --pythonPath = function()
            --return "/usr/bin/python3"
            --end
        },
        {
            type = "python",
            request = "attach",
            name = "Pytest file",
            program = "-m pytest ${file}"
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
    require "nvim-treesitter.configs".setup(
        {
            highlight = {
                enable = false, -- false will disable the whole extension
                disable = {} -- list of language that will be disabled
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

    require "nvim_rocks".ensure_installed({"fun", "30log", "lua-toml"})
end
