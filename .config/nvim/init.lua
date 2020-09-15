--
-- init.lua
-- Copyright (C) 2019 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

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
vim.api.nvim_command [[
function! DeleteTrailingWS()
exe 'normal mz'
%s/\s\+$//ge
exe 'normal `z'
endfunction
]]
--
--
--
--
local ok, nvim_rocks = pcall(require, "nvim_rocks")
if ok then
  nvim_rocks.ensure_installed("fun")
  nvim_rocks.ensure_installed("luasec", "fun", "30log", "lua-toml", "template", "lua-cjson")
  nvim_rocks.ensure_installed("luasocket")
end

if not filter then
  local ok, _ = pcall(require, "fun")
  if ok then
    require "fun"()
    vim.o.shell = head(filter(function(e) return vim.fn.executable(e) == 1 end, {"zsh", "fish", "bash"}))
  end
end

function D(a)
  print(vim.inspect(a))
  return a
end

function E(...)
  print(vim.inspect {...})
  return ...
end

local ok = pcall(require, "lsp_extensions")

if ok then
  vim.cmd [[
   autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
   ]]
  require "lsp_extensions".inlay_hints {
    highlight = "Comment",
    prefix = " > ",
    aligned = false,
    only_current_line = false
  }
end

local function collect(iterator)
  local rtn = {}
  for _, e in iterator do
    table.insert(rtn, e)
  end
  return rtn
end
local ok, nvim_lsp = pcall(require, "nvim_lsp")

if ok then
  local default_callback = vim.lsp.callbacks["textDocument/publishDiagnostics"]
  vim.lsp.callbacks["textDocument/publishDiagnostics"] = function(...)
    default_callback(...)

    require "lsp-ext".update_diagnostics()
  end
  local function on_attach(_)
    vim.fn.NvimLspMaps()
  end

  pcall(require, "nvim_lsp/sumneko_lua")
  if not require("nvim_lsp/configs").sumneko_lua.install_info().is_installed then
    require("nvim_lsp/configs").sumneko_lua.install()
  end

  local configs = require "nvim_lsp.configs"
  configs.zls = {
    default_config = {
      cmd = {
        "zls"
      },
      filetypes = {"zig"},
      root_dir = function(fname)
        return require "nvim_lsp/util".find_git_ancestor(fname) or vim.loop.os_homedir()
      end
    }
  }
  -- nvim_lsp.zls.setup {}

  nvim_lsp.gopls.setup {
    on_attach = on_attach,
    settings = {
      initializationOptions = {
        usePlaceholders = false
      }
    }
  }
  nvim_lsp.pyls.setup {
    on_attach = on_attach,
    settings = {
      pyls = {
        plugins = {
          pydocstyle = {
            enabled = false
          }
        }
      }
    }
  }
  nvim_lsp.tsserver.setup {
    on_attach = on_attach
  }
  nvim_lsp.clangd.setup {
    cmd = {
      "clangd-11",
      "--clang-tidy",
      "--all-scopes-completion",
      "--header-insertion=iwyu",
      "--background-index",
      "--suggest-missing-includes"
    },
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda"},
    on_attach = on_attach
  }
  nvim_lsp.sumneko_lua.setup {
    settings = {
      Lua = {
        diagnostics = {
          globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth"},
          disable = {"redefined-local"}
        },
        runtime = {version = "LuaJIT"}
      }
    },
    on_attach = on_attach
  }
  nvim_lsp.html.setup {
    on_attach = on_attach
  }

  nvim_lsp.rust_analyzer.setup {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        }
      },
      capabilities = {
        offsetEncoding = {"utf-8", "utf-16"},
        textDocument = {
          codeAction = {
            codeActionLiteralSupport = {
              codeActionKind = {
                valueSet = {}
              }
            },
            dynamicRegistration = false
          },
          completion = {
            completionItem = {
              commitCharactersSupport = false,
              deprecatedSupport = false,
              documentationFormat = {"markdown", "plaintext"},
              preselectSupport = false,
              snippetSupport = false
            },
            completionItemKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25
              }
            },
            contextSupport = false,
            dynamicRegistration = false
          },
          declaration = {
            linkSupport = true
          },
          definition = {
            linkSupport = true
          },
          documentHighlight = {
            dynamicRegistration = false
          },
          documentSymbol = {
            dynamicRegistration = false,
            hierarchicalDocumentSymbolSupport = true,
            symbolKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26
              }
            }
          },
          hover = {
            contentFormat = {"markdown", "plaintext"},
            dynamicRegistration = false
          },
          implementation = {
            linkSupport = true
          },
          references = {
            dynamicRegistration = false
          },
          signatureHelp = {
            dynamicRegistration = false,
            signatureInformation = {
              documentationFormat = {"markdown", "plaintext"}
            }
          },
          synchronization = {
            didSave = true,
            dynamicRegistration = false,
            willSave = false,
            willSaveWaitUntil = false
          },
          typeDefinition = {
            linkSupport = true
          }
        },
        workspace = {
          applyEdit = true,
          symbol = {
            dynamicRegistration = false,
            hierarchicalWorkspaceSymbolSupport = true,
            symbolKind = {
              valueSet = {
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26
              }
            }
          }
        }
      }
    },
    on_attach = on_attach
  }

  local java = function()
    pcall(require, "nvim_lsp/jdtls")
    if not require("nvim_lsp/configs").jdtls.install_info().is_installed then
      require("nvim_lsp/configs").jdtls.install()
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.codeAction = {
      dynamicRegistration = false,
      codeActionLiteralSupport = {
        codeActionKind = {
          valueSet = {
            "source.generate.toString",
            "source.generate.hashCodeEquals",
            "source.organizeImports"
          }
        }
      }
    }
    nvim_lsp.jdtls.setup {
      init_options = {
        bundles = {
          vim.fn.glob("~/.local/share/nvim/plugged/nvim-jdtls/*.jar")
        }
      },
      capabilities = capabilities,
      on_attach = function(client)
        on_attach(client)
        require("jdtls").setup_dap()
      end
    }
  end
  pcall(java)
  nvim_lsp.vimls.setup {
    on_attach = on_attach
  }
  nvim_lsp.yamlls.setup {
    on_attach = on_attach
  }
  nvim_lsp.jsonls.setup {
    on_attach = on_attach
  }
  --nvim_lsp.rust_analyzer.setup({})

  nvim_lsp.texlab.setup {
    settings = {
      latex = {
        build = {
          onSave = false
        },
        lint = {
          onSave = false,
          onChange = true
        }
      }
    },
    on_attach = on_attach
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
    args = {
      "-m",
      "debugpy.adapter"
    }
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
  dap.repl.commands =
    vim.tbl_extend(
    "force",
    dap.repl.commands,
    {
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
      into_targets = {".into_targets", "t"},
      capabilities = {".capabilities", ".ca"},
      custom_commands = {
        [".echo"] = function(text)
          dap.repl.append(text)
        end
      }
    }
  )
  vim.g.dap_virtual_text = true -- 'all frames'

  dap.adapters.cpp = {
    name = "cppdbg",
    type = "executable",
    command = vim.api.nvim_get_runtime_file("gadgets/linux/vscode-cpptools/debugAdapters/OpenDebugAD7", false)[1],
    args = {},
    attach = {
      pidProperty = "processId",
      pidSelect = "ask"
    }
    --configuration = {
    --type = "cppdbg",
    --args = {},
    --cwd = "${workspaceRoot}",
    --environment = {}
    --}
  }
  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005
    }
  }
  dap.adapters.lldb = {
    type = "executable",
    attach = {
      pidProperty = "pid",
      pidSelect = "ask"
    },
    command = "lldb-vscode-11",
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    },
    name = "lldb"
  }
  dap.adapters.markdown = {
    name = "cppdbg",
    command = "npm",
    args = {"run"},
    cwd = "/home/stephan/projects/vscode-mock-debug/"
  }

  if dap.custom_event_handlers then
    dap.custom_event_handlers.event_exited["my handler id"] = function(_, _)
      dap.repl.close()
      vim.cmd("stopinsert")
    end

    dap.custom_response_handlers.gotoTargets["my handler id"] = function(_, body)
      --dap.repl.append(vim.inspect(body))
    end
    dap.custom_event_handlers.event_stopped["my handler id"] = function(session, body)
      --dap.repl.append(vim.inspect(body))
      --dap.repl.append(vim.inspect(session))
    end
  end
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
local ok, _ = pcall(require, "nvim-treesitter.configs")
if ok then
  vim.cmd("set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")
  require "nvim-treesitter.parsers".get_parser_configs().lisp = {
    install_info = {
      url = "https://github.com/theHamsta/tree-sitter-clojure",
      files = {"src/parser.c"}
    }
  }
  require "nvim-treesitter.parsers".get_parser_configs().zig = {
    install_info = {
      url = "https://github.com/GrayJack/tree-sitter-zig",
      files = {"src/parser.c"}
    }
  }
  --require "nvim-treesitter.parsers".get_parser_configs().clojure = {
  --install_info = {
  --url = "https://github.com/oakmac/tree-sitter-clojure",
  --files = {"src/parser.c"},
  ----used_by = { "scheme" },
  --}
  --}
  --require "nvim-treesitter.parsers".get_parser_configs().regex = {
  --install_info = {
  --url = "https://github.com/tree-sitter/tree-sitter-regex",
  --files = {"src/parser.c"}
  --}
  --}
  require "nvim-treesitter.configs".setup(
    {
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {"html", "lua"} -- list of language that will be disabled
      },
      tree_docs = {
        enable = true,
        keymaps = {
          doc_node_at_cursor = "gdd",
          doc_all_in_range = "gdd"
        }
      },
      playground = {
        enable = true
      },
      incremental_selection = {
        -- this enables incremental selection
        enable = true,
        disable = {},
        keymaps = {
          init_selection = "<enter>", -- maps in normal mode to init the node/scope selection
          node_incremental = "<enter>", -- increment to the upper named parent
          scope_incremental = "Ts", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "grm"
        }
      },
      node_movement = {
        -- this enables incremental selection
        enable = true,
        highlight_current_node = true,
        disable = {},
        keymaps = {
          move_up = "<a-k>",
          move_down = "<a-j>",
          move_left = "<a-h>",
          move_right = "<a-l>",
          swap_up = "<s-a-k>",
          swap_down = "<s-a-j>",
          swap_left = "<s-a-h>",
          swap_right = "<s-a-l>",
          select_current_node = "<leader>ff"
        }
      },
      textobjects = {
        select = {
          enable = true,
          disable = {},
          keymaps = {
            ["iL"] = {
              python = "(function_definition) @function",
              cpp = "(function_definition) @function",
              c = "(function_definition) @function",
              java = "(method_declaration) @function"
            },
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ae"] = "@block.outer",
            ["ie"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["is"] = "@statement.inner",
            ["as"] = "@statement.outer",
            ["ad"] = "@comment.outer",
            ["id"] = "@comment.inner",
            ["am"] = "@call.outer",
            ["im"] = "@call.inner"
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<a-l>"] = "@parameter.inner",
            ["<a-f>"] = "@function.outer",
            ["<a-s>"] = "@statement.outer"
          },
          swap_previous = {
            ["<a-L>"] = "@parameter.inner",
            ["<a-F>"] = "@function.outer",
            ["<a-S>"] = "@statement.outer"
          }
        },
        move = {
          enable = true,
          goto_next_start = {
            ["öö"] = "@function.inner"
          },
          goto_previous_start = {
            ["üü"] = "@function.inner"
          }
        }
      },
      fold = {
        enable = true
      },
      refactor = {
        highlight_current_scope = {
          enable = false,
          inverse_highlighting = true,
          disable = {"python"}
        },
        highlight_definitions = {
          enable = true
          --disable = {"python"}
        },
        smart_rename = {
          enable = true,
          disable = {},
          keymaps = {
            smart_rename = "grr"
          }
        },
        navigation = {
          enable = true,
          disable = {},
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>"
          }
        }
      },
      ensure_installed = "all",
      disable = {"markdown"} -- list of language that will be disabled
      --update_strategy = 'newest'
    }
  )
  local hlmap = vim.treesitter.highlighter.hl_map

  --Misc
  hlmap.error = nil
  hlmap["punctuation.delimiter"] = "Delimiter"
  hlmap["punctuation.bracket"] = nil

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
  hlmap["keyword.function"] = "Function"
  hlmap["function.builtin"] = "Special"
  hlmap["function.macro"] = "Macro"
  hlmap["parameter"] = "Identifier"
  hlmap["method"] = "Function"
  hlmap["field"] = "Identifier"
  hlmap["property"] = "Type"
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
  hlmap["keyword.function"] = "Function"
  hlmap["variable"] = "Normal"

  local ok, docs = pcall(require, "nvim-tree-docs")
  if ok then
    docs.init()
  end
  local ok, play = pcall(require, "nvim-treesitter-playground")
  if ok then
    play.init()
  end
end

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
vim.cmd [[
    command! -nargs=* DebugJava lua require "my_debug".debug_java({<f-args>})
]]
vim.cmd [[
    command! SwitchHeaderSource lua require "lsp-ext".switch_header_source()
]]

vim.cmd("set guicursor+=a:blinkon333")
vim.cmd('set guifont="Noto_Sans:h8"')

--vim.api.nvim_command [[
--command! -nargs=1 JustTargets lua require "my_launcher".fuzzy_just(<f-args>)
--]]
